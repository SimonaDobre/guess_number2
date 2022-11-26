import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numberChoseByTheComputer = Random().nextInt(100) + 1;
  TextEditingController myController = TextEditingController();
  int? currentInputNumber = 0;
  int numberOfAttempts = 0;
  String infoAboutInputNumber = ' ';
  String recommendationToUser = ' ';
  bool numberNotGuessed = true;

  void newGame() {
    setState(() {
      numberChoseByTheComputer = Random().nextInt(100) + 1;
      currentInputNumber = 0;
      infoAboutInputNumber = ' ';
      recommendationToUser = ' ';
      numberNotGuessed = true;
      numberOfAttempts = 0;
    });
  }

  void adviceToUser() {
    setState(() {
      if (numberNotGuessed) {
        currentInputNumber = int.tryParse(myController.text);
        if (currentInputNumber == null) {
          recommendationToUser = 'Please input a valid number';
          infoAboutInputNumber = '';
        } else {
          numberOfAttempts += 1;
          if (numberOfAttempts == 0) {
            recommendationToUser = '';
          } else {
            infoAboutInputNumber = 'You chose $currentInputNumber';
            if (currentInputNumber! < numberChoseByTheComputer) {
              recommendationToUser = 'Input a bigger number';
            } else if (currentInputNumber! > numberChoseByTheComputer) {
              recommendationToUser = 'Input a lower number';
            } else {
              recommendationToUser = 'You guessed! Play again ?';
              numberNotGuessed = false;
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Please enter a number:'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: const TextStyle(fontSize: 25),
                  controller: myController,
                ),
              ),
              ElevatedButton(
                  child: const Text('TRY'),
                  onPressed: () {
                    adviceToUser();
                    myController.clear();
                  },),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'computer number = $numberChoseByTheComputer',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(infoAboutInputNumber),
                      subtitle: Text(recommendationToUser),
                    ),
                    Row(
                      children: <Widget>[
                        TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              newGame();
                            },),
                        TextButton(
                            child: const Text('No. Exit game!'),
                            onPressed: () {
                              exit(0);
                            },)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
