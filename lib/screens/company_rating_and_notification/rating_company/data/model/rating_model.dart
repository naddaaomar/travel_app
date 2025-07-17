class CompanyRatingModel {
  final String userId;
  final String name;
  final int companyId;
  final int rating;
  final String message;

  CompanyRatingModel({
    required this.userId,
    required this.name,
    required this.companyId,
    required this.rating,
    required this.message,
  });

  factory CompanyRatingModel.fromJson(Map<String, dynamic> json) {
    return CompanyRatingModel(
      userId: json['userId'],
      name: json['name'],
      companyId: json['companyId'],
      rating: json['rating'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'companyId': companyId,
      'rating': rating,
      'message': message,
    };
  }
}