import 'dart:async';

import 'package:flappybird_game/barrier.dart';
import 'package:flappybird_game/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(0, birdYaxis),
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text('')
                          : const Text(
                              'T A P   T O   P L A Y',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                    ),
                    AnimatedContainer(
                        alignment: Alignment(barrierXone, 1.1),
                        duration: const Duration(microseconds: 0),
                        child: const MyBarrier(
                          size: 200.0,
                        )),
                    AnimatedContainer(
                        alignment: Alignment(barrierXone, -1.1),
                        duration: const Duration(microseconds: 0),
                        child: const MyBarrier(
                          size: 200.0,
                        )),
                    AnimatedContainer(
                        alignment: Alignment(barrierXtwo, 1.1),
                        duration: const Duration(microseconds: 0),
                        child: const MyBarrier(
                          size: 200.0,
                        )),
                    AnimatedContainer(
                        alignment: Alignment(barrierXtwo, -1.1),
                        duration: const Duration(microseconds: 0),
                        child: const MyBarrier(
                          size: 150.0,
                        )),
                  ],
                )),
            Container(
              height: 10,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Color.fromARGB(255, 87, 64, 56),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '10',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'BEST SCORE',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '100',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
