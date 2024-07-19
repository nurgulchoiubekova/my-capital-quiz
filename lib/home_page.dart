import 'package:flutter/material.dart';
import 'package:flutter_capital_quiz/quiz_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> continents = [
    {'name': 'Europe', 'image': 'assets/continents/europe.png'},
    {'name': 'Asia', 'image': 'assets/continents/asia.png'},
    {'name': 'North America', 'image': 'assets/continents/north_america.png'},
    {'name': 'South America', 'image': 'assets/continents/south_america.png'},
    {'name': 'Africa', 'image': 'assets/continents/africa.png'},
    {'name': 'Australia', 'image': 'assets/continents/australia.png'},
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Континент танда',
          style: GoogleFonts.besley(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.more_vert),
          SizedBox(
            width: 20,
          ),
        ],
        shape: const Border(
            bottom: BorderSide(
          width: 2,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: continents.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // print('Tapped on ${continents[index]['name']}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuizPage(continent: continents[index]['name']!),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        continents[index]['name']!,
                        style: GoogleFonts.besley(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14)),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        continents[index]['image']!,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
