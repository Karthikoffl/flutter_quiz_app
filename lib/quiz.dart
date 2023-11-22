import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/questions_screen.dart';
import './start_screen.dart';
import "./data/questions.dart";
import "./results_screen.dart";

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> _selectedAnswers = [];
  var _activeScreen = "start-screen";

  void switchScreen() {
    setState(() {
      _activeScreen = "question-screen";
    });
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        _activeScreen = "results-screen";
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _selectedAnswers = [];
      _activeScreen = "questions-screen";
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (_activeScreen == "question-screen") {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (_activeScreen == "results-screen") {
      screenWidget = ResultsScreen(
        chosenAnswer: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
