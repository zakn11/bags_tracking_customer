import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class CustomeNumberFildOTP extends StatelessWidget {
  const CustomeNumberFildOTP({
    super.key,
    required this.onSaved,
    required this.onChanged,
  });
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        children: <Widget>[
          SizedBox(
            height: AppSizeH.s50,
            width: AppSizeW.s50,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppVar.primarySoft,
                  borderRadius: BorderRadius.circular(AppSizeR.s10)),
              child: TextFormField(
                
                decoration: const InputDecoration(
                  hintText: "0",
                  border: InputBorder.none,
                ),
                onSaved: onSaved,
                onChanged: onChanged,
                style: Theme.of(context).textTheme.headlineSmall,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
