import 'package:camera/camera.dart';
import 'package:driverassistant/mainpview.dart';
import 'package:driverassistant/trafficSigns/home.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras=null as List<CameraDescription>;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(mainpview());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tflite real-time detection',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(cameras),
    );
  }
}
