class Teacher {
  String name;
  String email;
  String subject;

  Teacher({required this.name, required this.email, required this.subject});

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'subject': subject,
  };

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    name: json['name'],
    email: json['email'],
    subject: json['subject'],
  );
}
