import 'package:flu_sms_send/Service/supabaseCredentials.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class AuthentificationService {
  Future<void> sendVerificationCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      final client = SupabaseCredentials.getClient();
      GotrueSessionResponse response = await client.auth.signIn(
        phone: phoneNumber,
        options: AuthOptions(
          redirectTo: SupabaseCredentials.APIURL,
        ),
      );

      if (response.error == null) {
        print(response.data);
      } else {
        print(response.error!.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Process failed: ${response.error!.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> verifyPhoneNumber({
    required BuildContext context,
    required String token,
    required String phoneNumber,
  }) async {
    try {
      final client = SupabaseCredentials.getClient();
      GotrueSessionResponse response =
          await client.auth.verifyOTP(phoneNumber, token);

      if (response.error == null) {
        print(response.data);
        print('SUCCESS');
      } else {
        print(response.error!.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Process failed: ${response.error!.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
