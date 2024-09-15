import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImageOrVideoPicker extends StatefulWidget {
  const ImageOrVideoPicker({super.key, required this.onChanged});

  final ValueChanged<List<String>> onChanged;

  @override
  State<ImageOrVideoPicker> createState() => _ImageOrVideoPickerState();
}

class _ImageOrVideoPickerState extends State<ImageOrVideoPicker> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _video;
  VideoPlayerController? _videoController;

  int _currIndex = 0;

  // limits
  final int _imageVideoLimit = 8;
  final int _videoLimit = 1;

  // errors
  bool _showWarning = false;
  String _warning = "";

  // image/video paths
  final List<String> _links = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _videoController?.dispose();

      _image = image;
      _video = null;

      //add path to links for form submission
      final imageLink = _image?.path;
      if (imageLink is String) {
        _links.add(imageLink);
        widget.onChanged(_links);
      }
    });
  }

  Future<void> _pickVideo() async {
    _videoController?.dispose();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _video = video;
        _image = null;

        _videoController = VideoPlayerController.file(File(video.path))
          ..initialize().then((_) {
            setState(() {}); // ensures first frame is displayed
          });

        //add path to links for form submission
        final videoLink = _video?.path;
        if (videoLink is String) {
          _links.add(videoLink);
          widget.onChanged(_links);
        }
      });
    }
  }

  void _removeImage(index) {
    setState(() {
      _links.removeAt(index);

      if (_currIndex >= _links.length && _links.isNotEmpty) {
        _currIndex = _links.length - 1;
      } else if (_links.isEmpty) {
        _currIndex = 0;
      }
    });
  }

  void _checkImageVideoLimit() {
    setState(() {
      if (_links.length < 8) {
        _warning = '';
        _showWarning = false;
      }
    });
  }

  bool isVideo(String link) {
    final String extension = link.split('.').last.toLowerCase();
    final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'webm'];

    return videoExtensions.contains(extension);
  }

  void _provideWarning(String warning) {
    setState(() {
      _showWarning = true;
      _warning = warning;
    });
  }

  void _disableWarning() {
    setState(() {
      _showWarning = false;
      _warning = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              Icon(
                Icons.upload,
                size: 32,
              ),
              SizedBox(width: 10),
              Text(
                style: TextStyle(
                  fontSize: 18,
                ),
                "Upload photo or video",
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (_links.length == _imageVideoLimit) {
                      _provideWarning(
                          "Limit reached, try removing an image or video first!");
                    } else {
                      _pickImage();
                    }
                  },
                  child: const Text("Choose Image")),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  List<String> videoLinks =
                      _links.where((link) => isVideo(link)).toList();
                  if (videoLinks.length >= _videoLimit) {
                    _provideWarning(
                        "Video limit reached, try removing a video first!");
                  } else {
                    _pickVideo();
                  }
                },
                child: const Text("Choose Video"),
              ),
            ],
          ),
          if (_showWarning) ...[
            const SizedBox(height: 20),
            const Icon(Icons.error, color: Colors.red),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    _warning,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          if (_links.isNotEmpty) ...[
            SizedBox(
              height: 300,
              width: 300,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 300,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currIndex = index;
                      });
                    }),
                items: _links.asMap().entries.map((entry) {
                  final index = entry.key;
                  final link = entry.value;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 140,
                            maxHeight: 300,
                          ),
                          child: AspectRatio(
                            aspectRatio: isVideo(link)
                                ? _videoController!.value.aspectRatio
                                : 1.0,
                            child: isVideo(link)
                                ? VideoContainer(link: link)
                                : ImageContainer(link: link),
                          ),
                        ),
                        const Positioned(
                          right: 5,
                          top: 5,
                          child: Icon(
                            Icons.circle,
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: GestureDetector(
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                            onTap: () {
                              _removeImage(index);
                              _checkImageVideoLimit();
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            if (_links.length >= 2) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_links.length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currIndex == index ? Colors.blueGrey : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
            ],
            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }
}

class VideoContainer extends StatefulWidget {
  const VideoContainer({super.key, required this.link});

  final String link;

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  VideoPlayerController? _videoController;

  final Icon _playIcon = const Icon(Icons.play_arrow);
  final Icon _pauseIcon = const Icon(Icons.pause);

  Icon _playPauseIcon = const Icon(Icons.play_arrow);

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.link))
      ..initialize().then((_) {
        setState(() {}); // Once initialized, update the UI
      });

    _videoController?.addListener(() {
      if (_videoController!.value.isCompleted) {
        setState(() {
          _playPauseIcon = _playIcon;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
      setState(() {
        _playPauseIcon = _playIcon;
      });
    } else {
      _videoController!.play();
      setState(() {
        _playPauseIcon = _pauseIcon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Colors.blueGrey,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: 
      (_videoController != null && _videoController!.value.isInitialized) ? // if video controller is initialized, then display it
        Stack(
          fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
            Positioned(
              bottom: 4, 
              right: 4,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  onPressed: _togglePlayPause,
                  backgroundColor: const Color.fromARGB(162, 184, 217, 251),
                  child: _playPauseIcon,
                ),
              ),
            ),
          ],
        )
      : // else
        const CircularProgressIndicator(),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.link,
  });

  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3.0,
          color: Colors.blueGrey,
        ),
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: FileImage(File(link)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
