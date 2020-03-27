import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
  ));
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<MyHome> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  bool playing = false;

  Widget slider() {
    return Slider(
        activeColor: Colors.black,
        inactiveColor: Colors.deepPurple,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.purple,
          ),
          onPressed: () {},
        ),
        title: Text(
          "Music is Love",
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.purple,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 26.0,
          ),
          Center(
              child: Container(
            width: 250.0,
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      shape: BoxShape.circle),
//                      child: Padding(
//                        padding: EdgeInsets.all(12.0),
//                        //child: BuildRadialSeekBar(),
//                      )
                ),
                Center(
                  child: Container(
                    width: 235.0,
                    height: 235.0,
                    child: ClipOval(
                        clipper: Mclipper(),
                        child: Image.asset(
                          "assets/see_you_again.jpg",
                          fit: BoxFit.cover,
                        )),
                  ),
                )
              ],
            ),
          )),
          SizedBox(
            height: 15.0,
          ),
          Column(
            children: <Widget>[
              Text("Wiz Khalifa",
                  style: TextStyle(fontSize: 20.0, color: Colors.deepPurple)),
              SizedBox(
                height: 8.0,
              ),
              Text(" See You Again ft.",
                  style: TextStyle(fontSize: 18.0, color: Colors.deepPurple)),
            ],
          ),
          Container(
            height: 100.0,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: -25,
                  child: Container(
                    width: 62.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      shape: BoxShape.circle,
                      //borderRadius:BorderRadius()
                    ),
                  ),
                ),
                Positioned(
                  left: 70,
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      shape: BoxShape.circle,
                      //borderRadius:BorderRadius()
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      width: 15.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        shape: BoxShape.circle,
                        //borderRadius:BorderRadius()
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -25,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                        color: Colors.purpleAccent, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
          slider(),
          Container(
            width: 300,
            height: 73,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 50.0,
                    width: 290.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 3.0),
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.skip_previous,
                              size: 38.0, color: Colors.purple),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(Icons.skip_next,
                              size: 38.0, color: Colors.purple)
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                        color: Colors.purple, shape: BoxShape.circle),
                    child: GestureDetector(
                        onTap: () {
                          playing = (!playing) ? false : true;
                        },
                        child: (!playing)
                            ? IconButton(
                                icon: Icon(Icons.play_arrow, size: 45),
                                onPressed: () {
                                  audioCache.play('Wiz_Khalifa.mp3');
                                  setState(() {
                                    playing = true;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.pause, size: 45),
                                onPressed: () {
                                  advancedPlayer.pause();
                                  setState(() {
                                    playing = false;
                                  });
                                },
                              )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Mclipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    return Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: min(size.width, size.height) / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
