import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exif/exif.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  // 画像を選択してExifデータから緯度経度を読み出す
  Future<void> _pickImageAndReadExif() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileBytes = await pickedFile.readAsBytes();
      Map<String, IfdTag> data = await readExifFromBytes(fileBytes);

      if (data == null || data.isEmpty) {
        print('no date');
      }

      for (String key in data.keys) {
        print("- $key (${data[key]!.tagType}) : ${data[key]}");
      }

      // final latitudeTag = data['GPS GPSLatitude'];
      // final longitudeTag = data['GPS GPSLongitude'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick Image and Read GPS Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: _pickImageAndReadExif,
          child: const Text('Pick Image'),
        ),
      ),
    );
  }
}
