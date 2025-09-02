import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/costume_login_TextField_widget.dart';
import 'package:tracking_system_app/widgets/general/defult_button.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppStrings() = AppStrings();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings().createNewPassword),
        titleTextStyle: const TextStyle(
          color: Color(0xff464646),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: GetBuilder<ForgetPasswordController>(
          init: Get.put(ForgetPasswordController()),
          builder: (controller) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: SizedBox(
                            width: AppSizeH.s250,
                            height: AppSizeH.s250,
                            child: Image.asset(
                              "assets/images/createnewpassword.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: controller.createPasswordFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20),
                              child: Text(
                                AppStrings().createYourNewPassword,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            CustomeLoginTextFormField(
                              filledTextFildData: null,
                              isFilledTextFild: null,
                              prefixIcon: const Icon(Icons.lock),
                              inputType: TextInputType.text,
                              hintText: '••••••••••••••••',
                              title: AppStrings().password,
                              controller: controller.passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings().pleaseEnterPassword;
                                }
                                return null;
                              },
                            ),
                            CustomeLoginTextFormField(
                              prefixIcon: const Icon(Icons.lock),
                              inputType: TextInputType.text,
                              hintText: '••••••••••••••••',
                              title: AppStrings().password,
                              controller: controller.confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings().pleaseConfirmPassword;
                                }
                                if (value !=
                                    controller.passwordController.text) {
                                  return AppStrings().passwordsDoNotMatch;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: DefultButton(
                          buttonColor: AppVar.primary,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          title: AppStrings().continue1,
                          onPressed: () async {
                            if (controller.createPasswordFormKey.currentState!
                                .validate()) {
                              await controller
                                  .sendRequestToLoginWithNewPassword();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                if (controller.isLoading.value)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          }),
    );
  }
}
