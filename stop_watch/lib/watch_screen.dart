import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              Text(
                "Stop Watch",
                textAlign: TextAlign.left,
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
            // SizedBox(
            //   height: 210,
            // ),

            Container(
              width: 250,
              height: 200,
              //color: Colors.amber,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Text(
                      '$digitalhour:$digitalminute:$digitalseconds',
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 130,
                  child: ElevatedButton.icon(
                    // color: Color.fromARGB(255, 205, 188, 252),
                    onPressed: () {
                      (!started) ? startTimer() : stopTimer();
                    },
                    label: Text(
                      (!started) ? "Start" : "Stop",
                    ),
                    icon: Icon(!(started) ? Icons.play_arrow : Icons.pause),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      resetTimer();
                    },
                    icon: Icon(Icons.replay_outlined),
                    label: Text("Reset"),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 36,
                ),
                SizedBox(
                    width: 100,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          addLaps();
                        },
                        icon: Icon(Icons.flag_circle),
                        label: Text("Lap"))),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  ...Laps.map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Lap : $e",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
