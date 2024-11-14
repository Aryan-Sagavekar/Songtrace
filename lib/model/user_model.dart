class UserData {
  final String id;
  final String name;

  UserData({
    required this.id,
    required this.name,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
    );
  }
}
