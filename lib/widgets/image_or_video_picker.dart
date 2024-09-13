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

  num _currIndex = 0;
  final num _imageVideoLimit = 2;

  bool _showWarning = false;
  String _warning = "";

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
                    if(_links.length == _imageVideoLimit){
                      setState(() {
                        _showWarning = true;
                        _warning = "You have reached the limit!";
                      });
                    } else {
                      _pickImage();
                    }
                  }, child: const Text("Choose Image")),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: _pickVideo, child: const Text("Choose Video")),
            ],
          ),
          if(_showWarning) ...[
            const SizedBox(height: 20),
            Text(
              _warning,
              style: const TextStyle(
                color: Colors.red,
              )
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
                  }
                ),
                items: _links.map((link) {

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 140,
                        maxHeight: 300,
                      ),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
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
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
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
                      color: _currIndex == index ? Colors.blueGrey : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 40),
          ],
          if (_video != null && _videoController != null) ...[
            _videoController!.value.isInitialized
                ? Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 16,
                        maxHeight: 300),
                    child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!)),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                });
              },
              child: Icon(_videoController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow),
            )
          ],
        ],
      ),
    );
  }
}
