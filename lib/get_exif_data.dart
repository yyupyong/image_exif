import 'dart:io';
import 'package:exif/exif.dart';

Future<void> readImageOrientation(String imagePath) async {
  final file = File(imagePath);
  final bytes = await file.readAsBytes();
  final exifData = await readExifFromBytes(bytes);

  final orientationTag = exifData['Image Orientation'];
  final orientationValue = orientationTag?.values.firstAsInt();

  int rotationAngle = 0;
  switch (orientationValue) {
    case 1: // 通常の向き
      rotationAngle = 0;
      break;
    case 3: // 180度回転
      rotationAngle = 180;
      break;
    case 6: // 右に90度回転
      rotationAngle = 90;
      break;
    case 8: // 左に90度回転
      rotationAngle = -90; // または 270
      break;
    default:
      rotationAngle = 0;
  }

  print("Image Orientation: $orientationValue");
  print("Rotation Angle: $rotationAngle degrees");
}
