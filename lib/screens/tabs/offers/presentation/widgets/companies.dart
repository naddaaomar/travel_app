class CompanyModel {
  String label;
  String imagePath;

  CompanyModel({
    required this.label,
    required this.imagePath,
  });

  static List<CompanyModel> Companies() {
    return [
      CompanyModel(
        label: "Com 1",
        imagePath: "assets/images/dahab1.jpg",
      ),
      CompanyModel(
        label: "Com 2",
        imagePath: "assets/images/dahab2.jpg",
      ),
      CompanyModel(
        label: "Com 3",
        imagePath: "assets/images/dahab3.jpg",
      ),
      CompanyModel(
        label: "Com 4",
        imagePath: "assets/images/dahab4.jpg",
      ),
      CompanyModel(
        label: "Com 5",
        imagePath: "assets/images/dahab5.jpg",
      ),
      CompanyModel(
        label: "Com 6",
        imagePath: "assets/images/dahab6.jpg",
      ),
      CompanyModel(
        label: "Com 7",
        imagePath: "assets/images/dahab1.jpg",
      ),
      CompanyModel(
        label: "Com 8",
        imagePath: "assets/images/dahab2.jpg",
      ),
      CompanyModel(
        label: "Com 9",
        imagePath: "assets/images/dahab3.jpg",
      ),
      CompanyModel(
        label: "Com 10",
        imagePath: "assets/images/dahab4.jpg",
      )
    ];
  }
}