import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageOrVideoPicker extends StatefulWidget {
  const ImageOrVideoPicker({super.key});

  @override
  State<ImageOrVideoPicker> createState() => _ImageOrVideoPickerState();
}

class _ImageOrVideoPickerState extends State<ImageOrVideoPicker> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _video;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _video = null;
    });
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.upload,
                size: 32,
              ),
              SizedBox(width: 20),
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
            Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            Text('Selected Image: ${_image!.name}'),
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
