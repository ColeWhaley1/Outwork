import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  List<String> _links = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _video = null;

      //add path to links for form submission
      final imageLink = _image?.path;
      if(imageLink is String){
        _links.add(imageLink);
        setState(() {
          widget.onChanged(_links);
        });
      }
    });
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
      _image = null;

      //add path to links for form submission
      final videoLink = _video?.path;
      if(videoLink is String){
        _links.add(videoLink);
        setState(() {
          widget.onChanged(_links);
        });
      }
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
                  onPressed: _pickImage, child: const Text("Choose Image")),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: _pickVideo, child: const Text("Choose Video")),
            ],
          ),
          const SizedBox(height: 20),
          if (_image != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 16,
                          maxHeight: 300),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          if (_video != null) ...[
            Container(
              width: 300,
              height: 200,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Video Selected: ${_video!.name}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
