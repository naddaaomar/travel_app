class UserProfile {
  final String name;
  final String email;
  final String password;

  UserProfile({
    required this.name,
    required this.email,
    required this.password,
  });

  int get passwordLength => password.length;

  UserProfile copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}