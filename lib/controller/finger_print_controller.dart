import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FingerprintController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  var isFingerprintEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFingerprintStatus();
  }

  Future<void> loadFingerprintStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isFingerprintEnabled.value = prefs.getBool('fingerprint_enabled') ?? false;
  }

  Future<void> setFingerprintEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fingerprint_enabled', value);
    isFingerprintEnabled.value = value;
  }

  Future<bool> authenticateWithFingerprint() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        return false;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return authenticated;
    } catch (e) {
      print('Fingerprint auth error: $e');
      return false;
    }
  }
}
