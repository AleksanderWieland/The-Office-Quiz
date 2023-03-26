class Quote {
  final int? id;
  final String quote;
  final String goodAnswer;

  Quote({
    this.id,
    required this.quote,
    required this.goodAnswer,
  });

  factory Quote.fromMap(Map<String, dynamic> json) => Quote(
        id: json['id'],
        quote: json['quote'],
        goodAnswer: json['goodAnswer'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'goodAnswer': goodAnswer,
    };
  }
}
