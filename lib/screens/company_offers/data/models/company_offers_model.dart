// class CompanyOffersModel {
//   String place;
//   String location;
//   double oldPrice;
//   double newPrice;
//   String category;
//   double discountPercentage;
//
//   CompanyOffersModel({
//     required this.place,
//     required this.location,
//     required this.oldPrice,
//     required this.newPrice,
//     required this.category,
//   }) : discountPercentage = ((oldPrice - newPrice) / oldPrice) * 100;
// }
//
//
// List<CompanyOffersModel> companyOffersModel = [
//   // Beach
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//   CompanyOffersModel(place: "Dahab", location: "South Sinai, Egypt", oldPrice:  500, newPrice:  400, category: "Beach"),
//   CompanyOffersModel(place: "Hurghada", location: "Red Sea Governorate", oldPrice:  700, newPrice:  500, category: "Beach"),
//   CompanyOffersModel(place: "Sharm El Sheikh", location: "South Sinai", oldPrice:  1000, newPrice:  800, category: "Beach"),
//   CompanyOffersModel(place: "Marsa Alam", location: "Red Sea Coast", oldPrice:  2000, newPrice:  1000, category: "Beach"),
//   CompanyOffersModel(place: "North Coast", location: "Mediterranean Sea, Egypt", oldPrice:  270, newPrice:  160, category: "Beach"),
//
//   // Religious
//   CompanyOffersModel(place: "Saint Catherine", location: "Mount Sinai", oldPrice:  180, newPrice:  110, category: "Religious"),
//   CompanyOffersModel(place: "Al Azhar Mosque", location: "Islamic Cairo", oldPrice:  180, newPrice:  130, category: "Religious"),
//   CompanyOffersModel(place: "Hanging Church", location: "Old Cairo", oldPrice:  120, newPrice:  110, category: "Religious"),
//   CompanyOffersModel(place: "Mosque of Muhammad Ali", location: "Cairo Citadel", oldPrice:  150, newPrice:  105, category: "Religious"),
//   CompanyOffersModel(place: "Saint Simon Monastery", location: "Mokattam Mountain, Cairo", oldPrice:  130, newPrice:  110, category: "Religious"),
//
//   // Safari
//   CompanyOffersModel(place: "White Desert", location: "Farafra Oasis", oldPrice:  300, newPrice:  200, category: "Safari"),
//   CompanyOffersModel(place: "Bahariya Oasis", location: "Western Desert", oldPrice:  280, newPrice:  180, category: "Safari"),
//   CompanyOffersModel(place: "Siwa Oasis", location: "Matrouh Governorate", oldPrice:  320, newPrice:  210, category: "Safari"),
//   CompanyOffersModel(place: "Fayoum Desert", location: "Wadi El Rayan", oldPrice:  260, newPrice:  170, category: "Safari"),
//   CompanyOffersModel(place: "Black Desert", location: "Near Bahariya Oasis", oldPrice:  290, newPrice:  190, category: "Safari"),
//
//   // Urban
//   CompanyOffersModel(place: "Cairo Downtown", location: "Tahrir Square, Cairo", oldPrice:  180, newPrice:  100, category: "Urban"),
//   CompanyOffersModel(place: "Alexandria", location: "Mediterranean Coast", oldPrice:  200, newPrice:  120, category: "Urban"),
//   CompanyOffersModel(place: "New Capital", location: "New Administrative Capital", oldPrice:  250, newPrice:  140, category: "Urban"),
//   CompanyOffersModel(place: "Zamalek", location: "Gezira Island, Cairo", oldPrice:  170, newPrice:  150, category: "Urban"),
//   CompanyOffersModel(place: "Maadi", location: "Southern Cairo", oldPrice:  160, newPrice:  125, category: "Urban"),
//
//   // Cultural
//   CompanyOffersModel(place: "Karnak Temple", location: "Luxor, Egypt", oldPrice: 300, newPrice: 220, category: "Cultural"),
//   CompanyOffersModel(place: "Luxor Temple", location: "Luxor City", oldPrice: 280, newPrice: 210, category: "Cultural"),
//   CompanyOffersModel(place: "Abu Simbel", location: "Aswan Governorate", oldPrice: 350, newPrice: 240, category: "Cultural"),
//   CompanyOffersModel(place: "Egyptian Museum", location: "Tahrir Square, Cairo", oldPrice: 200, newPrice: 150, category: "Cultural"),
//   CompanyOffersModel(place: "Valley of the Kings", location: "West Bank, Luxor", oldPrice: 320, newPrice: 230, category: "Cultural"),
//   // Nile Cruises
//   CompanyOffersModel(place: "Aswan to Luxor", location: "Nile River Cruise", oldPrice: 500, newPrice: 350, category: "Nile Cruises"),
//   CompanyOffersModel(place: "Luxor to Aswan", location: "Nile River Cruise", oldPrice: 480, newPrice: 330, category: "Nile Cruises"),
//   CompanyOffersModel(place: "Cairo Nile Dinner Cruise", location: "Zamalek, Cairo", oldPrice: 200, newPrice: 150, category: "Nile Cruises"),
//   CompanyOffersModel(place: "Nile Sunset Cruise", location: "Luxor, Egypt", oldPrice: 220, newPrice: 160, category: "Nile Cruises"),
//   CompanyOffersModel(place: "Felucca Ride", location: "Aswan Corniche", oldPrice: 150, newPrice: 120, category: "Nile Cruises"),
// ];
