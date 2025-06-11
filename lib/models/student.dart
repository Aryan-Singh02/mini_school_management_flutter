class Student {
  String name;
  String email;
  String className;

  Student({required this.name, required this.email, required this.className});

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'className': className,
  };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    name: json['name'],
    email: json['email'],
    className: json['className'],
  );
}
