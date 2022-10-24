import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces);
  int colorInt = 1;
  final Size absoluteImageSize;
  final List<Face> faces;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.limeAccent,
    Colors.orange
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    //for (Face face in faces) {
    try {
      // faces.sort()=>a.;
      Face face = faces[0];

      double averageEyeOpenProb =
          (face.leftEyeOpenProbability + face.rightEyeOpenProbability) / 2.0;
   var L= face.getLandmark(FaceLandmarkType.leftMouth);
   var R= face.getLandmark(FaceLandmarkType.rightMouth);
   var M= face.getLandmark(FaceLandmarkType.bottomMouth);
   var leftMouthx=L.position.dx;
   var leftMouthy=L.position.dy;
   var rightMouthx=R.position.dx;
   var rightMouthy=R.position.dy;
   var bottomMouthx=M.position.dx;
   var bottomMouthy=M.position.dy;
      var centerPointX = (leftMouthx + rightMouthx) / 2;
      var centerPointY = ((leftMouthy+ rightMouthy) / 2) - 20;


      var differenceX = centerPointX - bottomMouthx;
      var differenceY = centerPointY -bottomMouthy;
    /*  if(differenceY<(-60)){
        print("mouth is open");
        colorInt = 0;

        playSound();}
      else{
        print("close");
        colorInt = 1;
        stopSound();}*/

      print("hello");
     print("lefteyeprob${face.leftEyeOpenProbability}");
      print("righteyeprob${face.rightEyeOpenProbability}");

      print(averageEyeOpenProb);
        if (averageEyeOpenProb < 0.6 || differenceY<(-60)) {
        print("Alert");
        colorInt = 0;
       Future.delayed(Duration(seconds:2), (){playSound();});
       // playSound();

      } else {
       colorInt = 1;
        stopSound();
      }

      canvas.drawRect(
          // face.boundingBox,
          Rect.fromLTRB(
            face.boundingBox.left * scaleX,
            face.boundingBox.top * scaleY,
            face.boundingBox.right * scaleX,
            face.boundingBox.bottom * scaleY,
          ),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4.0
            ..color = colors[colorInt]);
    } catch (e) {
      print("noFaceDetected");
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  void playSound(){
    assetsAudioPlayer.open(
      Audio("assets/alarm.mp3"),
    );
   assetsAudioPlayer.loopMode.value;
    print('play sound');
    assetsAudioPlayer.play();
  }
  void stopSound(){

  //  assetsAudioPlayer.loopMode.value;
    print('stop sound');
    assetsAudioPlayer.stop();
  }
}
