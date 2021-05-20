import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_snake_game/body_data.dart';
import 'package:flutter_snake_game/food.dart';
import 'package:flutter_snake_game/my_button.dart';
import 'dart:math';
import 'package:flutter_snake_game/snake_body.dart';

double food() {
  Random food = Random();
  int num = food.nextInt(200);
  num = num - 100;
  return num / 100;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlaying = false;
  String direction = "left";
  bool anAxis = true;
  Timer _timer;
  double foodX = food();
  double foodY = food();
  int score = 0;
  int speed = 130;
  BodyData head = BodyData(0, 0);

  List<BodyData> snakeList = [];

  @override
  void initState() {
    // TODO: implement initState
    if (snakeList.isEmpty) {
      snakeList.add(head);
    }
    super.initState();
  }

  void snakeMove(turn, bool axis) {
    if (axis == anAxis) {
      print("going there");
    } else {
      _timer.cancel();
      snakeStart(turn);
      direction = turn;
    }
  }

  snakeStart(direction) {
    _timer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      if (isPlaying == false) {
        timer.cancel();
      } else {
        setState(() {
          snakeDirection(direction);
          foodAte();
        });
        if (snakeList.length > 8) {
          ateSelf();
        }
      }
    });
  }

  void ateSelf() {
    for (int i = 4; i < snakeList.length; i++) {
      if ((head.dataX - snakeList[i].dataX).abs() < 0.04 &&
          (head.dataY - snakeList[i].dataY).abs() < 0.04) {
        setState(() {
          isPlaying = false;
        });
        showYouDied(context);
      }
    }
  }

  showYouDied(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            title: Text("You Died"),
            actions: [
              TextButton(onPressed: () {}, child: Text("Quit")),
              TextButton(
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Text("Restart"),
              )
            ],
          );
        });
  }

  restartGame() {
    setState(() {
      score = 0;
      direction = "left";
      anAxis = true;
      foodY = food();
      foodX = food();
      isPlaying = false;
      snakeList = [];
      head = BodyData(0, 0);
      snakeList.add(head);
    });
  }

  void foodAte() {
    if ((head.dataX - foodX).abs() < 0.03 &&
        (head.dataY - foodY).abs() < 0.03) {
      foodY = food();
      foodX = food();
      score += 2;

      BodyData tail = snakeList.last;
      for (int i = 1; i < 8; i++) {
        snakeList.add(BodyData(tail.dataX, tail.dataY));
        tail.next = snakeList.last;
        tail = snakeList.last;
      }
      print(score);
    }
  }

  void snakeDirection(direction) {
    head.moveData();
    head.movingBody();
    head.headMove(direction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake Game'),
        actions: [
          IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
                snakeStart(direction);
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.brown, width: 7)),
              child: Stack(children: [
                Food(foodX, foodY),
                Stack(
                    children: snakeList
                        .map((snake) => MyBody(snake.dataX, snake.dataY))
                        .toList()),
              ]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    function: () {
                      snakeMove('up', false);
                      anAxis = false;
                    },
                    child: Icon(Icons.arrow_upward),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      MyButton(
                        function: () {
                          snakeMove('left', true);
                          anAxis = true;
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      MyButton(
                        function: () {
                          snakeMove('right', true);
                          anAxis = true;
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                  MyButton(
                    function: () {
                      snakeMove('down', false);
                      anAxis = false;
                    },
                    child: Icon(Icons.arrow_downward),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
