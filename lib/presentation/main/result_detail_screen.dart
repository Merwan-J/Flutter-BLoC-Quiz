import 'package:bloc_quiz/infrastructure/result/result_repo.dart';
import 'package:flutter/material.dart';
import 'package:fl_score_bar/fl_score_bar.dart';
import 'package:bloc_quiz/infrastructure/util/category_detail_list.dart';

class ResultDetailScreen extends StatelessWidget {
  final double score;
  final int categoryIndex;
  final String difficultyLevel;
  final int attempts;
  final int wrongAttempts;
  final int correctAttempts;
  final bool isSaved;

  final ResultRepo resultRepo = ResultRepo();

  ResultDetailScreen(
      {Key? key,
      required this.score,
      required this.categoryIndex,
      required this.attempts,
      required this.wrongAttempts,
      required this.correctAttempts,
      required this.difficultyLevel,
      required this.isSaved})
      : super(key: key) {
    if (isSaved == false) {
      resultRepo.saveScore(
          score,
          difficultyLevel,
          attempts,
          wrongAttempts,
          correctAttempts,
          categoryDetailList[categoryIndex].title,
          categoryIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: categoryDetailList[categoryIndex].textColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${categoryDetailList[categoryIndex].title}: ${difficultyLevel.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Attempts: ${attempts.toString()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Wrong Attempts: ${wrongAttempts.toString()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Correct Attempts: ${correctAttempts.toString()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 0.3 * MediaQuery.of(context).size.width,
                  height: 0.08 * MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 3),
                        blurRadius: 0.7,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check,
                    color: categoryDetailList[categoryIndex].textColor,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
