import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CamreInput extends StatefulWidget {
  const CamreInput({super.key, required this.onpickimage});
  final void Function(File image) onpickimage;

  @override
  State<CamreInput> createState() => _CamreInputState();
}

class _CamreInputState extends State<CamreInput> {
  File? _takenimage;

  void _takephoto() async {
    final imagepicker = ImagePicker();
    final pickedimage = await imagepicker.pickImage(source: ImageSource.camera,maxWidth: 600);
    if (pickedimage == null) {
      return;
    }
    setState(() {
      _takenimage = File(pickedimage.path);
    });
    widget.onpickimage(_takenimage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takephoto,
        icon: const Icon(Icons.camera),
        label: const Text("Take Photo"));

    if (_takenimage != null) {
      content = GestureDetector(
        onTap: _takephoto,
        child: Image.file(
          _takenimage!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        child: content);
  }
}
