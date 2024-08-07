import 'package:flu_sms_send/Service/supabaseCredentials.dart';
import 'package:flu_sms_send/home.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class Verify extends StatefulWidget {
  final String numero;
  const Verify({super.key, required this.numero});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  List<String> enteredDigits = List.filled(6, '');
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 50),
              Container(
                  child: const Text("Authentification",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))),
              Center(
                child: Container(
                  width: 350,
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => _buildDigitBox(index),
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            String otp = enteredDigits.join();

                            final client = SupabaseCredentials.getClient();
                            GotrueSessionResponse response =
                                await client.auth.verifyOTP(widget.numero, otp);

                            if (response.error == null) {
                              print(response.data);
                              print('SUCCESS');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                              if (otp == "123456") {
                              } else {
                                setState(() {
                                  errorMessage = 'Code incorrect';
                                });
                              }
                            } else {
                              print(response.error!.message);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Process failed: ${response.error!.message}")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 25, 88, 139),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Continuer",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigitBox(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            onChanged: (value) {
              if (value.isNotEmpty && value.length == 1) {
                _updateDigit(index, value);
                if (index < 5) {
                  FocusScope.of(context).nextFocus();
                }
              } else if (value.isEmpty) {
                _removeDigit(index);
              }
              setState(() {
                errorMessage = enteredDigits.contains('')
                    ? 'Saisissez le code complet'
                    : '';
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '', // Supprime le compteur de texte
            ),
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _updateDigit(int index, String value) {
    setState(() {
      enteredDigits[index] = value;
    });
  }

  void _removeDigit(int index) {
    if (index > 0) {
      _updateDigit(index - 1, '');
    }
  }
}
