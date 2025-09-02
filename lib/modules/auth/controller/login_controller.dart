import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tracking_system_app/alert.dart';
import 'package:tracking_system_app/helpers/helpers.dart';
import 'package:tracking_system_app/network_util.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';
import 'package:tracking_system_app/widgets/auth/login-defult_button.dart';
import 'package:tracking_system_app/widgets/general/main_loading_widget.dart';
import 'package:tracking_system_app/widgets/toast/custom_toast.dart';

class LoginController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  RxInt lockoutTimer = 30.obs;
  Timer? countdownTimer;
  RxBool isButtonLooked = false.obs;
  RxBool isButtonLookedPermently = false.obs;
  final LocalAuthentication localAuth = LocalAuthentication();
  RxBool isBiometricAvailable = false.obs;
  RxBool isBiometricEnabled = false.obs;
  RxBool isFirstLogin = true.obs;
  RxDouble fingerprintOpacity = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkFirstLogin();
    checkBiometrics();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

//-------------------------------------------------------------------
  void startLockoutTimer() {
    isButtonLooked.value = true;
    lockoutTimer.value = 30;
    countdownTimer?.cancel();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (lockoutTimer.value > 0) {
        lockoutTimer.value--;
      } else {
        timer.cancel();
        isButtonLooked.value = false;
      }
    });
  }

//-------------------------------------------------------------------
  Future<void> checkFirstLogin() async {
    try {
      final cachedCredentials = await $.getpasswordAndPhoneCachedCredentials();
      isFirstLogin.value = cachedCredentials == null;
      fingerprintOpacity.value = isFirstLogin.value ? 0.5 : 1.0;
    } catch (e) {
      print("Error in checkFirstLogin: $e");
      isFirstLogin.value = true;
      fingerprintOpacity.value = 0.5;
    }
  }

//-------------------------------------------------------------------
  Future<void> checkBiometrics() async {
    try {
      final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      isBiometricAvailable.value =
          canCheckBiometrics && availableBiometrics.isNotEmpty;
      isBiometricEnabled.value = isBiometricAvailable.value;
    } catch (e) {
      isBiometricAvailable.value = false;
      isBiometricEnabled.value = false;
      print('Error checking biometrics: $e');
    }
  }
//-------------------------------------------------------------------

  Future<void> authenticateWithBiometrics() async {
    if (isFirstLogin.value) {
      Alert.infoDialog(
        message: '''Please login manually.
You can use fingerprint on your next login.''',
      );
      return;
    }

    try {
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Authenticate to login to the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        login();
      }
    } on PlatformException catch (e) {
      log("${e.toString()}");
      if (e.code == 'no_fragment_activity') {
        CustomToast.errorToast("Configuration Error",
            "Please update your Android app configuration for biometric support");
      } else if (e.code == "LockedOut") {
        startLockoutTimer();
        Alert.infoDialog(
            message:
                "The app is locked out due to too many attempts. Please wait for 30 seconnds and try again");
      } else if (e.code == 'PermanentlyLockedOut') {
        isButtonLookedPermently.value = true;
        showDeviceCredentialsBottomSheet();
      } else {
        log("${e.toString()}");

        CustomToast.errorToast("Authentication Error",
            "Biometric authentication failed: ${e.message}");
      }
    } catch (e) {
      log("${e.toString()}");

      CustomToast.errorToast("Error", "An unexpected error occurred");
    }
  }
//-------------------------------------------------------------------

  Future<void> showDeviceCredentialsBottomSheet() async {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(AppSizeW.s20),
        decoration: BoxDecoration(
          color: AppVar.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizeR.s20),
            topRight: Radius.circular(AppSizeR.s20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Device Authentication Required',
              style: TextStyle(
                color: AppVar.error,
                fontSize: AppSizeSp.s20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizeH.s20),
            Text(
              'You\'ve exceeded the maximum attempts. '
              'Please use your device PIN/Pattern/Password to unlock biometric authentication.',
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: AppVar.seconndTextColor,
                fontSize: AppSizeSp.s14,
              ),
            ),
            SizedBox(height: AppSizeH.s30),
            LoginDefultButton(
              fontsize: AppSizeSp.s16,
              buttonColor: AppVar.primary,
              borderColor: Colors.transparent,
              textColor: AppVar.seconndTextColor,
              title: "AUTHENTICATE",
              onPressed: () async {
                try {
                  final bool didAuthenticate = await localAuth.authenticate(
                    localizedReason: 'Verify your identity to continue',
                    options: const AuthenticationOptions(
                      biometricOnly: false,
                      useErrorDialogs: true,
                      stickyAuth: true,
                    ),
                  );

                  if (didAuthenticate) {
                    isButtonLookedPermently.value = false;
                    Get.back(); // here i close the bottom sheet
                    login();
                  }
                } on PlatformException catch (e) {
                  CustomToast.errorToast("Authentication Failed",
                      e.message ?? "Could not verify your identity");
                }
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }


  bool validateForm() {
    if (phoneNumberController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your phone number');
      return false;
    }

    // final RegExp uaePhoneRegex =
    //     // RegExp(r'^(?:50|51|52|55|56|58|2|3|4|6|7|9)\d{7}$');
    //     RegExp(r'^(?:5)\d{8}$');

    // if (!uaePhoneRegex.hasMatch(phoneNumberController.text)) {
    //   Get.closeAllSnackbars();
    //   CustomToast.errorToast(
    //       'Error', 'Please enter a valid Emirates phone number');
    //   return false;
    // }

    if (passwordController.text.isEmpty) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Please enter your password');

      return false;
    } else if (passwordController.text.length < 6) {
      Get.closeAllSnackbars();
      CustomToast.errorToast('Error', 'Password must be at least 6 characters');

      return false;
    }
    login();
    return true;
  }

  String normalizePhoneNumber(String phone) {
    // مثال: +9630969830277
    final regex = RegExp(r'^\+(\d+?)0(\d+)$');
    final match = regex.firstMatch(phone);

    if (match != null) {
      // رمز الدولة
      final countryCode = match.group(1)!; // 963
      // الرقم بدون الصفر
      final restNumber = match.group(2)!; // 969830277
      return '+$countryCode$restNumber';
    }
    return phone; // اذا ما كان فيه صفر بعد الكود رجعه متل ما هو
  }

//---------------------------------------------------------------------------
  Future<void> login() async {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    Get.dialog(
      const Center(
        child: MainLoadingWidget(),
      ),
      barrierDismissible: false,
    );

    isLoading.value = true;
    try {
      final cachedCredentials = await $.getpasswordAndPhoneCachedCredentials();
      //this condition for:
      //اذا الاكاش مو فاضي والفيلدين مالهم فاليديت واليوزر مستمعل بصمة فببعتهم من الكاش

      final bool usingCachedCredentials =
          cachedCredentials != null && !validateForm();
      log("zak1 ${phoneNumberController.text} zak1");
      final formattedPhone = normalizePhoneNumber(phoneNumberController.text);

      log("zak $formattedPhone zak");
      final response = await $.post(
        '/loginUser',
        body: usingCachedCredentials
            ? cachedCredentials
            : {
                'phone': formattedPhone,
                'password': passwordController.text,
              },
      );
      log("zak1");
      if (response != null) {
        log("zak2");
        //TO PREVENT THE ADMIN TO SIGN IN TO APP
        //TO PREVENT THE ADMIN TO SIGN IN TO APP
        if (response['data']['role'] == "admin" ||
            response['data']['role'] == "super_admin" ||
            response['data']['role'] == "admin_cook" ||
            response['data']['role'] == "driver" ||
            response['data']['role'] == "store_employee") {
          Get.offAllNamed(Routes.LOGIN);
          Alert.infoDialog(
              message: tr('You do not have permissions to sign this app in.'));
        } else {
          // اذا اول مرة بفوت على التطبيق فما اعرضلو زر البصمة، يعني بكل تسجيل دخول بس
          //يف بالكاش
          log("zak7");
          log("TOKEN => ${response['data']['token']}");
          log("ROLE => ${response['data']['role']}");
          log("PHONE => ${usingCachedCredentials ? cachedCredentials["phone"] : formattedPhone}");
          log("PASS => ${usingCachedCredentials ? cachedCredentials["password"] : passwordController.text}");

          await $.setConnectionParams(
            //هون عم حط الكاش احيانا مرة تانية بقلب الكاش لان مشان خلي القيمة نفسها بكل تسجيلة دخول من البصمة
            password: usingCachedCredentials
                ? cachedCredentials["password"]!
                : passwordController.text,
            phoneNumber: usingCachedCredentials
                ? cachedCredentials["phone"]!
                : formattedPhone,
            token: response['data']['token'],
            userRole: response['data']['role'],
          );
          // Navigate to Home page on successful login
          Get.offAllNamed(Routes.HOME);
          Alert.toast('Logged in successfully');
        }
      }
    } catch (e) {
      log("zak2");
      // If decryption fails, clear the corrupted credentials
      if (e is ArgumentError || e.toString().contains('decryption')) {
        await $.resetUserAfterEncrypt();
        Alert.infoDialog(message: 'Session expired. Please login again.');
        return;
      }
      CustomToast.errorToast("Error", "Error because : ${e.toString()}");
      log("zak error ${e.toString()}");
    } finally {
      log("zak3");
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
