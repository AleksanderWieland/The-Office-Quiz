import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quotes/database/database_helper.dart';
import 'package:quotes/models/question.dart';
import 'package:quotes/models/quote.dart';
import '../answer_buttons.dart';
import 'package:quotes/models/character.dart';
import '../const.dart';
import '../requests/network_helper.dart';
import 'bad_answer_page.dart';
import 'good_answer_page.dart';

class QuizPage extends StatefulWidget {
  QuizPage({super.key});
  int questionNumber = 0;
  int points = 0;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void resetOrIncrementQuestionNumber(List<Question> list) {
    if (widget.questionNumber < list.length - 1) {
      widget.questionNumber++;
    } else {
      widget.questionNumber = 0;
    }
  }

  void resetOrDecrementQuestionNumber(List<Question> list) {
    if (widget.questionNumber == 0) {
      widget.questionNumber = list.length - 1;
    } else {
      widget.questionNumber--;
    }
  }

  void incrementOrResetPoints(List<Question> list) {
    if (widget.questionNumber < list.length - 1) {
      widget.points++;
    } else {
      widget.points = 0;
    }
  }

  final preparePageFunc = futureBuilderPreparePage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: preparePageFunc,
      builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
        bool isAnwerEqualToGoodAnswer(int numerOfAnswer) {
          var answer = snapshot
              .data![widget.questionNumber].answers![numerOfAnswer]
              .toString();
          var goodAnswer = snapshot.data![widget.questionNumber].goodAnswer;
          if (answer.compareTo(goodAnswer!) == 0) {
            return true;
          } else {
            return false;
          }
        }

        Widget child;
        if (snapshot.hasData && snapshot.data!.isEmpty == false) {
          String question =
              snapshot.data![widget.questionNumber].question.toString();
          child = Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black26,
              title: Center(
                child: Text(
                  'Guess The Office Quote!',
                  style: answerPageTextStyle.copyWith(fontSize: 25),
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text(
                        'Question ${widget.questionNumber + 1}/${snapshot.data!.length.toString()} | Points: ${widget.points}',
                        textAlign: TextAlign.center,
                        style: answerButtonsStyle),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white30,
                      border: Border(
                        top: BorderSide(),
                        left: BorderSide(),
                        right: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 80.0, left: 30.0, right: 30.0, bottom: 10.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(question,
                            textAlign: TextAlign.justify,
                            style: answerPageTextStyle.copyWith(
                                fontSize: 22, color: Colors.black)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0),
                      child: Column(
                        children: [
                          AnswerButtons(
                            functionOnTap: () async {
                              setState(() {
                                if (isAnwerEqualToGoodAnswer(0)) {
                                  incrementOrResetPoints(snapshot.data!);
                                  navigateToGoodAnswerPage(context);
                                } else {
                                  navigateToBadAnswerPage(context);
                                }
                                resetOrIncrementQuestionNumber(snapshot.data!);
                              });
                            },
                            buttonText: snapshot
                                .data![widget.questionNumber].answers![0]
                                .toString(),
                          ),
                          SizedBox(height: answerPageBoxHeight),
                          AnswerButtons(
                            functionOnTap: () async {
                              setState(() {
                                if (isAnwerEqualToGoodAnswer(1)) {
                                  incrementOrResetPoints(snapshot.data!);
                                  navigateToGoodAnswerPage(context);
                                } else {
                                  navigateToBadAnswerPage(context);
                                }
                                resetOrIncrementQuestionNumber(snapshot.data!);
                              });
                            },
                            buttonText: snapshot
                                .data![widget.questionNumber].answers![1]
                                .toString(),
                          ),
                          SizedBox(height: answerPageBoxHeight),
                          AnswerButtons(
                            functionOnTap: () {
                              setState(() {
                                if (isAnwerEqualToGoodAnswer(2)) {
                                  incrementOrResetPoints(snapshot.data!);
                                  navigateToGoodAnswerPage(context);
                                } else {
                                  navigateToBadAnswerPage(context);
                                }
                                resetOrIncrementQuestionNumber(snapshot.data!);
                              });
                            },
                            buttonText: snapshot
                                .data![widget.questionNumber].answers![2]
                                .toString(),
                          ),
                          SizedBox(height: answerPageBoxHeight),
                          AnswerButtons(
                            functionOnTap: () {
                              setState(() {
                                if (isAnwerEqualToGoodAnswer(3)) {
                                  incrementOrResetPoints(snapshot.data!);
                                  navigateToGoodAnswerPage(context);
                                } else {
                                  navigateToBadAnswerPage(context);
                                }
                                resetOrIncrementQuestionNumber(snapshot.data!);
                              });
                            },
                            buttonText: snapshot
                                .data![widget.questionNumber].answers![3]
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        buttonWidthMultiplier,
                    height: MediaQuery.of(context).size.height *
                        buttonHeightMultiplier,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              resetOrDecrementQuestionNumber(snapshot.data!);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              border: Border(
                                top: BorderSide(),
                                left: BorderSide(),
                                right: BorderSide(),
                                bottom: BorderSide(),
                              ),
                            ),
                            child: SizedBox(
                              width: 80.0,
                              child: Center(
                                child: Text(
                                  '<',
                                  style: answerButtonsStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Image(
                          image: AssetImage(
                            'assets/logo.png',
                          ),
                          color: Colors.black,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              resetOrIncrementQuestionNumber(snapshot.data!);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              border: Border(
                                top: BorderSide(),
                                left: BorderSide(),
                                right: BorderSide(),
                                bottom: BorderSide(),
                              ),
                            ),
                            child: SizedBox(
                              width: 80.0,
                              child: Center(
                                child: Text(
                                  '>',
                                  style: answerButtonsStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          child = Scaffold(
            body: Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ],
            ),
          );
        } else {
          child = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Downloading data\ninto database...'),
                ),
              ],
            ),
          );
        }
        return child;
      },
    );
  }
}

Future<List<Question>> futureBuilderPreparePage() async {
  await prepareDatabase();
  return await createAllQuestions();
}

Future<List<Question>> createAllQuestions() async {
  List<Quote> quotes = await DatabaseHelper.instance.getQuotes();
  final List<String> allCharacterNamesAndSurnames =
      await getAllCharactersNamesAndLastnames();
  List<String> allCharacterNamesAndSurnamesToEdit = [];
  allCharacterNamesAndSurnamesToEdit = List.from(allCharacterNamesAndSurnames);
  List<Question> questions = [];
  for (Quote quote in quotes) {
    String goodAnswer = quote.goodAnswer;
    allCharacterNamesAndSurnamesToEdit =
        List.from(allCharacterNamesAndSurnames);

    List<String> randomAnswers =
        getRandomAnswers(allCharacterNamesAndSurnamesToEdit, goodAnswer);
    Question question = Question(
        question: quote.quote, answers: randomAnswers, goodAnswer: goodAnswer);
    questions.add(question);
  }
  questions.shuffle();
  return questions;
}

Future<void> prepareDatabase() async {
  bool isCharactersTableEmpty =
      await DatabaseHelper.instance.isCharactersTableEmpty();
  bool isQuotesTableEmpty = await DatabaseHelper.instance.isQuotesTableEmpty();
  // await DatabaseHelper.instance.printCharactersTable();
  // await DatabaseHelper.instance.removeAllCharacters();
  // await DatabaseHelper.instance.removeAllQuotes();
  // await Future.delayed(Duration(seconds: 5));
  isCharactersTableEmpty
      ? DatabaseHelper.instance.addCharactersToDatabase(
          await NetworkHelper('https://officeapi.dev/api/characters').getData(),
        )
      : () {};
  isQuotesTableEmpty
      ? DatabaseHelper.instance.addQuotesToDatabase(
          await NetworkHelper('https://officeapi.dev/api/quotes').getData())
      : () {};
}

Future<List<String>> getAllCharactersNamesAndLastnames() async {
  List<Character> characters = await DatabaseHelper.instance.getCharacters();
  List<String> charactersNamesAndLastnames = [];
  for (Character character in characters) {
    charactersNamesAndLastnames.add(character.firstnameAndLastname);
  }
  return charactersNamesAndLastnames;
}

List<String> getRandomAnswers(
    List<String> allCharactersNamesAndLastNames, String goodAnswer) {
  Random random = Random();
  int howManyAnswers = 3;
  List<String> answers = [];
  allCharactersNamesAndLastNames.remove(goodAnswer);
  for (int i = 0; i < howManyAnswers; i++) {
    int randomNumber = random.nextInt(allCharactersNamesAndLastNames.length);
    String generatedAnswer = allCharactersNamesAndLastNames[randomNumber];
    answers.add(generatedAnswer);
    allCharactersNamesAndLastNames.remove(generatedAnswer);
  }
  answers.add(goodAnswer);
  answers.shuffle();
  return answers;
}

Future<dynamic> navigateToGoodAnswerPage(context) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoodAnswerPage(),
      ),
    );

Future<dynamic> navigateToBadAnswerPage(context) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BadAnswerPage(),
      ),
    );
