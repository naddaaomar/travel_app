
import 'package:p/screens/booking/data/models/BookingModel.dart';

abstract class BookingDs {
  Future<BookingModel> booking(
      {required String buyerEmail,
        required int travelId,
        required int quantity,
      }
      );
}
