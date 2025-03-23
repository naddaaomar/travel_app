import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';

class LocationCardNew extends StatelessWidget {
  const LocationCardNew({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return Card(
      color: isLight ? Color(0xFFD7D1D1) : Color(0xFF8C8282),
      elevation: 3,
      shadowColor: isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Expanded(
            child: DropdownSearch<String>(
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  hintText: "Where to?",
                  hintStyle: TextStyle(
                      color: isLight ? Colors.black54 : Colors.white54,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
              ),
              suffixProps: DropdownSuffixProps(
                  clearButtonProps:
                      ClearButtonProps(isVisible: false, color: Colors.red)),
              dropdownBuilder: (context, selectedItem) {
                return Text(
                  selectedItem ?? "",
                  style: TextStyle(
                    color: isLight ? Colors.black : Colors.white,
                    fontSize: 18.sp,
                  ),
                );
              },
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                color:
                    isLight ? ColorApp.primaryColor : ColorApp.primaryColorDark,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
