// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:gradient_borders/box_borders/gradient_box_border.dart';
// import 'package:p/helpers/themes/colors.dart';
//
// List<String> selectedItems = [];
//
// final ValueNotifier<bool> isFieldFocused =
//     ValueNotifier<bool>(false); // Make sure this exists
//
// Widget buildFilters({required void Function(VoidCallback) onPressed}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//     child: Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 35,
//             child: ListView.separated(
//               separatorBuilder: (context, index) => SizedBox(
//                 width: 10,
//               ),
//               itemCount: selectedItems.length,
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemBuilder: (context, index) => Container(
//                 padding: EdgeInsets.only(left: 9),
//                 decoration: BoxDecoration(
//                   color: ColorApp.primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       selectedItems[index],
//                       style: TextStyle(color: Colors.white,fontSize: 12, fontFamily: "pop"),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         onPressed(() { // Call the provided setState function
//                           selectedItems.removeAt(index);
//                           isFieldFocused.value = selectedItems.isNotEmpty; // Update visibility
//                         });
//                       },
//                       icon: Icon(
//                         Icons.clear,
//                         size: 15,
//                         color: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// void showFilterDialog(BuildContext context) {
//   final List<String> items = [
//     'Trip',
//     'Company',
//     'Event',
//
//   ];
//
//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Dialog(
//             backgroundColor: ColorApp.secondaryColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 400,
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 border: GradientBoxBorder(
//                   gradient: LinearGradient(colors: [
//                     Color(0xffFFB184),
//                     ColorApp.primaryColor,
//                     Color(0xff7F5E41)
//                   ]),
//                   width: 5,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Filter Search",
//                       style: TextStyle(fontSize: 18, fontFamily: "vol"),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       DropdownButtonHideUnderline(
//
//                         child: DropdownButton2<String>(
//
//                           isExpanded: true,
//                           hint: Text(
//                             'Search for',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Theme.of(context).hintColor,
//                             ),
//                           ),
//                           items: items.map((item) {
//                             return DropdownMenuItem(
//
//                               value: item,
//                               enabled: false,
//                               child: StatefulBuilder(
//
//                                 builder: (context, menuSetState) {
//                                   final isSelected = selectedItems.contains(item);
//                                   return InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         isSelected
//                                             ? selectedItems.remove(item)
//                                             : selectedItems.add(item);
//                                         isFieldFocused.value = selectedItems
//                                             .isNotEmpty; // Ensure UI updates
//                                       });
//                                       menuSetState(
//                                           () {}); // Update dropdown state
//                                     },
//                                     child: Container(
//                                       height: double.infinity,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16.0),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             isSelected
//                                                 ? Icons.check_box_outlined
//                                                 : Icons.check_box_outline_blank,
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             child: Text(
//                                               item,
//                                               style: const TextStyle(
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             );
//                           }).toList(),
//                           value: selectedItems.isNotEmpty
//                               ? selectedItems.last
//                               : null,
//                           onChanged: (value) {},
//                           selectedItemBuilder: (context) {
//                             return items.map((item) {
//                               return Container(
//                                 alignment: AlignmentDirectional.center,
//                                 child: Text(
//                                   selectedItems.join(', '),
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   maxLines: 1,
//                                 ),
//                               );
//                             }).toList();
//                           },
//                           buttonStyleData:  ButtonStyleData(
//                             padding: EdgeInsets.only(left: 16, right: 8),
//                             height: 40,
//                             width: 250,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: GradientBoxBorder(
//                                 gradient: LinearGradient(colors: [
//                                   Color(0xffFFB184),
//                                   Color(0xff7F5E41)
//                                 ]),
//                                 width: 2,
//                               ),                            )
//                           ),
//                           menuItemStyleData: const MenuItemStyleData(
//                             height: 40,
//
//                             padding: EdgeInsets.zero,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: ColorApp.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         "Done",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "pop",
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
