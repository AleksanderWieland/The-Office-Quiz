class Question {
  final String? question;
  final List<String>? answers;
  final String? goodAnswer;

  Question(
      {required this.question,
      required this.answers,
      required this.goodAnswer});

  factory Question.fromMap(Map<String, dynamic> json) => Question(
      question: json['question'],
      answers: json['answers'],
      goodAnswer: json['goodAnswer']);

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      'goodAnswer': goodAnswer,
    };
  }
}
