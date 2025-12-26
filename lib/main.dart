import 'package:flutter/material.dart';

import 'question_bank.dart';

QuestionBank questionbank = QuestionBank();

void main() => runApp(const QuizzApp());

class QuizzApp extends StatelessWidget {
  const QuizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = questionbank.getAnswer();
    if (userPickedAnswer == correctAnswer) {
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
    }

    // If finished show simple AlertDialog
    if (questionbank.isFinished()) {
      // compute simple score (count checks)
      final int correctCount = scoreKeeper.where((i) {
        return (i.icon == Icons.check);
      }).length;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade800,
            title: const Text(
              'Quiz Completed!',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'You scored $correctCount out of ${questionbank.getTotalQuestions()}.',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    questionbank.reset();
                    scoreKeeper.clear();
                  });
                },
                child: const Text(
                  'Restart',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        questionbank.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int total = questionbank.getTotalQuestions();
    final int current = questionbank.getQuestionNumber() + 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // small header: progress text
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
          child: Text(
            'Question $current / $total',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),

        // Question area with subtle card look
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  questionbank.getQuestion(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        // True button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => checkAnswer(true),
              child: const Text('True', style: TextStyle(fontSize: 18.0)),
            ),
          ),
        ),

        // False button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => checkAnswer(false),
              child: const Text('False', style: TextStyle(fontSize: 18.0)),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(children: scoreKeeper),
        ),
      ],
    );
  }
}
