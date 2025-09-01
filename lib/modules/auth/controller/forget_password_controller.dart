import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_system_app/modules/auth/controller/otp_timer_controller.dart';
import 'package:tracking_system_app/modules/auth/view/otp/create_new_password_page.dart';
import 'package:tracking_system_app/modules/auth/view/otp/otp_page.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class ForgetPasswordController extends GetxController {
  bool isEmailValid = true;
  String email = "";

  String? otpNumber1 = "";
  String? otpNumber2 = "";
  String? otpNumber3 = "";
  String? otpNumber4 = "";
  String? otpNumber5 = "";
  String? otpNumber6 = "";

  final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final createPasswordFormKey = GlobalKey<FormState>();
  // RxBool isWaitAdminApproved = false.obs;
  var statusCode = 0.obs;
  var isLoading = false.obs;

  RxBool isOtpComplete = false.obs;

  void checkOtpComplete() {
    isOtpComplete.value = otpNumber1 != "" &&
        otpNumber2 != "" &&
        otpNumber3 != "" &&
        otpNumber4 != "" &&
        otpNumber5 != "" &&
        otpNumber6 != "";
  }

  void showLoadingDialog() {
    Get.dialog(
      const Center(
        child: MainLoadingWidget(),
      ),
      barrierDismissible: false,
    );
  }

//=========================== 1 ===========================
  Future<void> customerForgetPassword({required String email}) async {
    isLoading.value = true;
    try {
      final response =
          await $.post('/customerForgetPassword', body: {"email": email});

      if (response != null) {
        Get.to(() => OtpPage(
              email: emailController.text,
            ));
        CustomToast.successToast("Good",
            "A verification code has been sent to your email. It will expire in 5 minutes.");
        final TimerController timerController = Get.put(TimerController());

        timerController.startTimer();
      }

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

//=========================== 2 ===========================
  Future<void> customerCheckCode() async {
    isLoading.value = true;
    try {
      final response = await $.post('/customerCheckCode', body: {
        "code":
            "$otpNumber1$otpNumber2$otpNumber3$otpNumber4$otpNumber5$otpNumber6"
      });

      if (response != null) {
        Get.to(() => const CreateNewPasswordPage());
        // CustomToast.successToast("Good", "A verification code has been sent to your email. It will expire in 5 minutes.");
      }

      isLoading.value = false;
    } catch (e) {
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

//=========================== 3 ===========================
  Future<void> sendRequestToLoginWithNewPassword() async {
    isLoading.value = true;
    try {
      final response = await $.post('/customerResetPassword', body: {
        "code":
            "$otpNumber1$otpNumber2$otpNumber3$otpNumber4$otpNumber5$otpNumber6",
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      });
      // Get.back();

//if success :

      if (response != null) {
        // loginAfterSuccessResetPassword();
        passwordController.text = "";
        confirmPasswordController.text = "";
        otpNumber1 = "";
        otpNumber2 = "";
        otpNumber3 = "";
        otpNumber4 = "";
        otpNumber5 = "";
        otpNumber6 = "";
        Get.offAllNamed(Routes.LOGIN);
        CustomToast.successToast(
            "Good", "Password created successfully, try to Login");
      }

      isLoading.value = false;
    } catch (e) {
      // if (Get.isDialogOpen!) {
      //   Get.back();
      // }
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  String maskEmailOtp(String email) {
    int visibleChars = 6;
    int index = email.indexOf('@');
    if (index <= visibleChars) return email;
    String maskedPart = '*' * (index - visibleChars);
    return email.substring(0, visibleChars) +
        maskedPart +
        email.substring(index);
  }
}
