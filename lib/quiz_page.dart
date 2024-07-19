// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_capital_quiz/data.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPage extends StatefulWidget {
  final String continent;
  const QuizPage({super.key, required this.continent});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int lives = 3;
  int currentQuestionIndex = 0;
  late List<Map<String, dynamic>> continentQuestions;

  @override
  void initState() {
    super.initState();
    continentQuestions = questions[widget.continent]!;
    continentQuestions.shuffle();
  }

  void checkAnswer(String answer) {
    if (answer == continentQuestions[currentQuestionIndex]['capital']) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Туура! Азаматсыз!"),
          backgroundColor: const Color.fromARGB(255, 182, 233, 128),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  if (currentQuestionIndex < continentQuestions.length - 1) {
                    currentQuestionIndex++;
                  } else {
                    currentQuestionIndex =
                        0; //Бардык суроолордон кийин кайра баштайт
                  }
                });
              },
              child: const Text(
                "Кийинки",
                style: TextStyle(
                  color: Color.fromARGB(255, 35, 51, 138),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      setState(() {
        lives -= 1;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Ката!"),
          backgroundColor: const Color.fromARGB(255, 234, 79, 73),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (lives == 0) {
                  // Жандар түгөнүп калса, континент тандоо барагына кайтат
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Кайра байкап көрүңүз",
                style: TextStyle(color: Color.fromARGB(255, 35, 51, 138)),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (continentQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Оюн'),
        ),
        body: const Center(
          child: Text('Бул континент үчүн суроолор жок.'),
        ),
      );
    }

    var currentQuestion = continentQuestions[currentQuestionIndex];
    var options = List<String>.from(currentQuestion['options']);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.continent} '),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              lives,
              (index) => const Icon(Icons.favorite,
                  color: Color.fromARGB(255, 223, 37, 24)),
            ),
          ),
        ],
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Center(
        //       child: Text('Жандар: $lives'),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${currentQuestion['country']}',
              style: GoogleFonts.besley(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              currentQuestion['image'],
              height: 200,
              width: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 60),
                        elevation: 5, 
                        shadowColor: Colors.black, 
                      ),
                      onPressed: () {
                        checkAnswer(options[index]);
                      },
                      child: Text(
                        options[index],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 22, 9, 112),
                            fontSize: 18),
                      ),
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
