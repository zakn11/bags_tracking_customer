import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tracking_system_app/shared/shared.dart';


class StripeService {
  //the constructer is only accessible private
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret =
      //here i will pass amount as $
          await _cereatePaymentIntent(100, "usd");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Zakaria Na"),
      );
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _cereatePaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();

      Map<String, dynamic> data = {
        //if i want to charge the user 1$, i will put 100  in amount cause the 100 is cents not dollars
        //so i calculate the amount in the fun below dibening on the case.
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "Authorization": "Bearer $stripeScretkey",
            "Content-Type": "application/x-www-form-urllencoded",
          }));
      if (response.data != null) {
        // print(' response.data: ${response.data}');
        return response.data["client_secret"];
        // return response.data;
      }
      return null;
    } catch (e) {
      print('e: ${e}');
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
