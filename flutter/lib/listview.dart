import 'package:driverassistant/CameraPreview.dart';
import 'package:driverassistant/main.dart';
import 'package:flutter/material.dart';

class listview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (context) => CameraPreviewScanner(),
        '/b': (context) => MyApp(),
      },
      home: Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(backgroundColor: Colors.teal,title: Text("SMART ALARM"),),
        body: Builder(
          builder: (ctx) => ListView(
            children: [
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(ctx, '/a');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.deepOrange,
                  elevation: 30,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  15,
                                ),
                                topRight: Radius.circular(
                                  15,
                                )),
                            child: Image.asset(
                              "assets/drwosniess.jpg",
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 100,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                              color: Colors.black54,
                              width: 220,
                              child: Text(
                                "Drowsniess Detection",
                                style: TextStyle(
                                    fontSize: 26, color: Colors.white),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(ctx, '/b');
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.deepOrange,
                  elevation: 30,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  15,
                                ),
                                topRight: Radius.circular(
                                  15,
                                )),
                            child: Image.asset(
                              "assets/traffic.jpg",
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 100,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                              color: Colors.black54,
                              width: 220,
                              child: Text(
                                "Traffic Signs",
                                style: TextStyle(
                                    fontSize: 26, color: Colors.white),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
