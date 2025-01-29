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
        label: "Cam 1",
        imagePath: "assets/images/dahab1.jpg",
      ),
      CompanyModel(
        label: "Cam 2",
        imagePath: "assets/images/dahab2.jpg",
      ),
      CompanyModel(
        label: "Cam 3",
        imagePath: "assets/images/dahab3.jpg",
      ),
      CompanyModel(
        label: "Cam 4",
        imagePath: "assets/images/dahab4.jpg",
      ),
      CompanyModel(
        label: "Cam 5",
        imagePath: "assets/images/dahab5.jpg",
      ),
      CompanyModel(
        label: "Cam 6",
        imagePath: "assets/images/dahab6.jpg",
      ),
      CompanyModel(
        label: "Cam 7",
        imagePath: "assets/images/dahab1.jpg",
      ),
      CompanyModel(
        label: "Cam 8",
        imagePath: "assets/images/dahab2.jpg",
      ),
      CompanyModel(
        label: "Cam 9",
        imagePath: "assets/images/dahab3.jpg",
      ),
      CompanyModel(
        label: "Cam 10",
        imagePath: "assets/images/dahab4.jpg",
      )
    ];
  }
}
