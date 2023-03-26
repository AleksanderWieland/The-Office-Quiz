class Character {
  final int? id;
  final String firstnameAndLastname;

  Character({this.id, required this.firstnameAndLastname});

  factory Character.fromMap(Map<String, dynamic> json) => Character(
        id: json['id'],
        firstnameAndLastname: json['firstnameAndLastname'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstnameAndLastname': firstnameAndLastname,
    };
  }
}
