import 'package:flu_sms_send/Service/notifier.dart';
import 'package:flu_sms_send/verify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Notifier SendSms = Provider.of<Notifier>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text("Bienvenue"),
              ),
              Container(
                width: 350,
                child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        labelText: "Mot de passe",
                        hintText: "Entrer un mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ))),
              ),
              const SizedBox(
                height: 30,
              ),
              // Button pour l'envoie d'sms et la navigation
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 25, 88, 139),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Verify(
                                numero: phoneController.text,
                              )),
                    );
                    SendSms.sendVerificationCode(
                        context: context, phoneNumber: phoneController.text);
                  },
                  child: const Text(
                    "Envoyer le code",
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
