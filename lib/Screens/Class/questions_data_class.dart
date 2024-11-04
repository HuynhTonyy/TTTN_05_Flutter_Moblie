class Question {
  final int id;
  final String question;
  final String type;
  final Map<String, String> options;

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
  });

  // Factory method to create an instance of Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      type: json['type'],
      options: Map<String, String>.from(json['options']),
    );
  }
}
