class ProjectFaqModel {
  final String id;
  final String question;
  final String answer;

  ProjectFaqModel({required this.id, required this.question, required this.answer});

  factory ProjectFaqModel.fromJson(Map<String, dynamic> json) {
    return ProjectFaqModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}
