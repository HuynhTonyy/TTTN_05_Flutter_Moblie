class Question {
  final int id;
  final String question;
  final String type;
  final Map<String, String> options;
  final List<dynamic> columns;

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
    required this.columns
  });

  // Factory method to create an instance of Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      type: json['type'],
      columns: json['columns'],
      options: Map<String, String>.from(json['options']),
    );
  }
}
