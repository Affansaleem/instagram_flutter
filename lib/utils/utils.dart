import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No image selected");
}

snackBar(String contents, BuildContext context, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      contents,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      textAlign: TextAlign.center,
    ),
    backgroundColor: color,
  ));
}
