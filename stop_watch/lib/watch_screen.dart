import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stop_watch/common_widgets/buttons.dart';
import 'package:stop_watch/common_widgets/play_pause_button.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  int seconds = 0, minutes = 0, hour = 0;
  String digitalseconds = '00', digitalminute = '00', digitalhour = '00';
  Timer? timer;
  bool started = false;
  List Laps = [];

// stop function
  void stopTimer() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

// reset function
  void resetTimer() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hour = 0;

      digitalseconds = "00";
      digitalminute = "00";
      digitalhour = "00";

      Laps.clear();
      started = false;
    });
  }

// start timer
  void startTimer() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int localSecond = seconds + 1;
        int localMinutes = minutes;
        int localHour = hour;

        if (localSecond > 59) {
          localSecond = 0;
          if (localMinutes > 59) {
            localMinutes = 0;
            localHour++;
          } else {
            localMinutes++;
          }
        }

        seconds = localSecond;
        minutes = localMinutes;
        hour = localHour;

        digitalseconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitalminute = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitalhour = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

// adding laps
  void addLaps() {
    String laps = "$digitalhour : $digitalminute : $digitalseconds";
    setState(() {
      Laps.add(laps);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          title: Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Stop Watch",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 205, 188, 252),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 105,
            ),
            Container(
              width: 285,
              height: 265,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 500,
                    width: 330,
                    child: CircularProgressIndicator(
                      value: seconds / 60,
                      strokeWidth:
                          18, // adjust the thickness of the progress indicator
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 205, 188, 252),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        '$digitalhour:$digitalminute:$digitalseconds',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    addLaps();
                  },
                  icon: Icon(Icons.flag),
                  width: 125,
                  label: "Lap",
                ),
                SizedBox(
                    height: 60,
                    width: 87,
                    child: PlayPauseButton(50, () {
                      (!started ? startTimer() : stopTimer());
                    },
                        Icon(
                          !started ? Icons.play_arrow : Icons.pause,
                          size: 35,
                        ))),
                CustomButton(
                  onPressed: () {
                    resetTimer();
                  },
                  icon: Icon(Icons.replay),
                  width: 125,
                  label: "Reset",
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Laps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Lap : ${Laps[index]}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
