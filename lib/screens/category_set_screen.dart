import 'package:flutter/material.dart';
import 'package:quziapp/model/model.dart';
import 'package:quziapp/screens/quiz_screen.dart';

class CategorySetScreen extends StatelessWidget {
  final Category category;

  const CategorySetScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
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
                      '${category.name} Quiz',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: category.quizSets.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final QuizSet = category.quizSets[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contex) {
                              return QuizScreen(
                                quizSet: QuizSet,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.indigo, Colors.purpleAccent],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.3,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(category.image),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              QuizSet.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
