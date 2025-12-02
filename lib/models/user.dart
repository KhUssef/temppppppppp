class User {
  String email;
  String fullName;

  User({this.email = '', this.fullName = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'] as String? ?? '',
        fullName: json['fullName'] as String? ?? '',
      );

  Map<String, String> toJson() => {
        'email': email,
        'fullName': fullName,
      };
}
