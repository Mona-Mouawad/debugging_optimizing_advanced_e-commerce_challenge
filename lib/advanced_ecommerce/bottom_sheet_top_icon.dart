import 'package:flutter/material.dart';

class BottomSheetTopIcon extends StatelessWidget {
  const BottomSheetTopIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 5,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.50),
          ),
        ),
      ),
    );
  }
}
