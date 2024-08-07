import 'package:flu_sms_send/Service/notifierService.dart';
import 'package:flutter/material.dart';

class Notifier extends ChangeNotifier {
  final AuthentificationService _authentificationService =
      new AuthentificationService();

  // ignore: body_might_complete_normally_nullable
  Future<String?> sendVerificationCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      _authentificationService.sendVerificationCode(
          context: context, phoneNumber: phoneNumber);
    } catch (e) {
      print(e);
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> verifyPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
    required String token,
  }) async {
    try {
      _authentificationService.verifyPhoneNumber(
          context: context, token: token, phoneNumber: phoneNumber);
    } catch (e) {
      print(e);
    }
  }
}
