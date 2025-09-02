import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/forget_password_controller.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/general/costume_TextField_widget.dart';
import 'package:tracking_system_app/widgets/general/defult_button.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/shared/app_strings.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(AppStrings().forgotPassword),
            titleTextStyle: const TextStyle(
              color: Color(0xff464646),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            leading: IconButton(
              color: AppVar.textColor,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
            ),
          ),
          body: GetBuilder<ForgetPasswordController>(
            init: ForgetPasswordController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                "assets/images/Logo1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizeH.s20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            AppStrings().selectContactDetails,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 350,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppSizeR.s10),
                              ),
                              border: Border.all(
                                color: AppVar.primary,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppVar.primarySoft,
                                    ),
                                    width: 60,
                                    height: 60,
                                    child: Icon(
                                      Icons.email,
                                      color: AppVar.primary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        AppStrings().viaEmail,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade500),
                                      ),
                                    ),
                                    // ignore: missing_required_param
                                    subtitle: CustomeTextFormField(
                                      hintText: "********@gmail.com",
                                      inputType: TextInputType.emailAddress,
                                      title: "",
                                      controller: controller.emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings().pleaseEnterEmail;
                                        }

                                        return null;
                                      },
                                      prefixIcon: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                              if (controller.formKey.currentState!.validate()) {
                                await controller.customerForgetPassword(
                                    email: controller.emailController.text);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: MainLoadingWidget(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
