import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../../../../helpers/themes/colors.dart';
import '../../data/model/rating_model.dart';
import '../manager/rating_cubit.dart';

class RatingInputSection extends StatefulWidget {
  final int companyId;
  final String userId;
  final String userName;

  const RatingInputSection({
    required this.companyId,
    required this.userId,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  State<RatingInputSection> createState() => RatingInputSectionState();
}

class RatingInputSectionState extends State<RatingInputSection> {
  double _rating = 0;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate US',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'vols'),
            ),
            const SizedBox(height: 12),
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                itemCount: 5,
                allowHalfRating: false,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber),
                onRatingUpdate: (value) => setState(() => _rating = value),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: GradientBoxBorder(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffFFB184),
                      Color(0xff7F5E41),
                    ],
                  ),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Add your review (optional)',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorApp.thirdColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorApp.thirdColor.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
            )
            ,
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: GradientBoxBorder(
                    gradient: LinearGradient(
                        colors: const [
                      Color(0xffFFB184),
                      Color(0xff7F5E41)
                    ]),
                    width: 2,
                  ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ElevatedButton(
                  onPressed: _rating == 0 ? null : _submitRating,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Submit Rating',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'vols'
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRating() {
    final model = CompanyRatingModel(
      userId: widget.userId,
      name: widget.userName,
      companyId: widget.companyId,
      rating: _rating.round(),
      message: _messageController.text,
    );
    context.read<CompanyRatingCubit>().submitRating(model);
  }
}
