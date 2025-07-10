// class EventInteraction {
//   String id;
//   String type;
//   int userCheckOut;
//   bool addedToWishList;
//   bool booked;
//   double total;
//
//   EventInteraction(
//       {required this.id,
//         required this.type,
//         required this.userCheckOut,
//         required this.addedToWishList,
//         required this.booked,
//       }):total = userCheckOut +
//       (addedToWishList ? 2 : 0) +
//       (booked ? 9 : 0);
//   void recalculateTotal() {
//     total = userCheckOut + (addedToWishList ? 2 : 0) + (booked ? 9 : 0);
//   }
//
// }