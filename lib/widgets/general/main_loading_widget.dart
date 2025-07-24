import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizeW.s50,
        height: AppSizeH.s50,
        child: Lottie.asset(
          fit: BoxFit.fill,
          'assets/Lottie/MainLoadingIndecetor.json',
        ),
      ),
    );
  }
}
