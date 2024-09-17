import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressItem extends StatelessWidget {
  final String streetAddress;
  final String roadAddress;

  const AddressItem(
      {super.key, required this.streetAddress, required this.roadAddress});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(streetAddress),
      SizedBox(height: 6.w),
      Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 2.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(roadAddress),
          ),
          SizedBox(width: 6.w),
          Text(roadAddress),
        ],
      )
    ]);
  }
}
