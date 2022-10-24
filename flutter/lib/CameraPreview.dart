import 'package:camera/camera.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'detector_painters.dart';
import 'scanner_utils.dart';
class CameraPreviewScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CameraPreviewScannerState();
}
class _CameraPreviewScannerState extends State<CameraPreviewScanner> {
  dynamic _scanResults;
  CameraController _camera;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;

  final FaceDetector _faceDetector = GoogleVision.instance.faceDetector(
      FaceDetectorOptions(
          mode: FaceDetectorMode.fast,
          enableLandmarks: true,
          enableClassification: true,
          enableContours: true
          // enableTracking: true
          ));

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);
    setState(() {});
    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.android
          ? ResolutionPreset.veryHigh
          : ResolutionPreset.high,
    );
    await _camera.initialize().catchError((onError) => print(onError));

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _faceDetector.processImage ,
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          setState(() {
            _scanResults = results;
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Widget _buildResults() {
    Text noResultsText = Text(' ');

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );
    if (_scanResults is! List<Face>) return noResultsText;
    painter = FaceDetectorPainter(imageSize, _scanResults);

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.teal,
      child: _camera == null
          ? Center(
              child: Text(
                'Initializing Camera...',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30.0,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CameraPreview(_camera),
                  _buildResults(),
                  // Text(face)
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: _buildImage(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

        ],
      ),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _faceDetector.close();
    });

    super.dispose();
  }

}
