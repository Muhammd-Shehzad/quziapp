import 'package:flutter/material.dart';
import 'package:quziapp/model/model.dart';
import 'package:quziapp/screens/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizSet quizSet;

  QuizScreen({super.key, required this.quizSet});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedAnswers = List.filled(widget.quizSet.questions.length, null);
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.quizSet.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion =
        widget.quizSet.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purpleAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text(
                      widget.quizSet.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.purpleAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.3,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        currentQuestion.question,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ...currentQuestion.options.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final option = entry.value;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAnswers[currentQuestionIndex] = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            margin: EdgeInsets.symmetric(
                                vertical: 9, horizontal: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.indigo, Colors.purpleAccent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 0.3,
                                  offset: Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        selectedAnswers[currentQuestionIndex] ==
                                                index
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentQuestionIndex > 0
                        ? GestureDetector(
                            onTap: () {
                              goToPreviousQuestion();
                            },
                            child: Container(
                              height: 50,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.indigo,
                                      Colors.purpleAccent
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                border: Border.all(color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.3,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    GestureDetector(
                      onTap: () {
                        if (currentQuestionIndex <
                            widget.quizSet.questions.length - 1) {
                          goToNextQuestion();
                        } else {
                          int totalCorrect = 0;
                          for (int i = 0;
                              i < widget.quizSet.questions.length;
                              i++) {
                            if (selectedAnswers[i] ==
                                widget.quizSet.questions[i].selectedIndex) {
                              totalCorrect++;
                            }
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ResultScreen(
                                  totalQuestions:
                                      widget.quizSet.questions.length,
                                  totalAttempts:
                                      widget.quizSet.questions.length,
                                  totalCorrect: totalCorrect,
                                  totalScore: totalCorrect * 10,
                                  quizSet: widget.quizSet,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [Colors.indigo, Colors.purpleAccent],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.3,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            currentQuestionIndex ==
                                    widget.quizSet.questions.length - 1
                                ? 'Submit'
                                : 'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
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
