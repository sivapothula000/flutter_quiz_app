import 'Question.dart';

class QuestionBank {
  int _questionNumber = 0;
  int getQuestionNumber() => _questionNumber;
  int getTotalQuestions() => _questionBank.length;

  final List<Question> _questionBank = [
    Question(
      questionText:
          'The Great Wall of China can be seen from space with the naked eye',
      questionAnswer: false,
    ),
    Question(
      questionText:
          'Honey never spoils and can stay edible for thousands of years.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'Lightning never strikes the same place twice.',
      questionAnswer: false,
    ),
    Question(
      questionText:
          'Octopuses have blue blood because they use copper to carry oxygen.',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'The Sahara Desert was once a green land with lakes and rivers.',
      questionAnswer: true,
    ),
    Question(
      questionText:
          'Bananas are slightly radioactive due to natural potassium.',
      questionAnswer: true,
    ),
    Question(
      questionText: 'Mount Everest is the closest point on Earth to the moon.',
      questionAnswer: false,
    ),
    Question(
      questionText: 'Humans use only 10% of their brain.',
      questionAnswer: false,
    ),
    Question(
      questionText: 'Goldfish have a memory of only three seconds.',
      questionAnswer: false,
    ),
    Question(
      questionText: 'Turtles can breathe through their butts while underwater',
      questionAnswer: true,
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}
