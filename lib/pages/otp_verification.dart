
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:test/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/pages/sign_up.dart';


class OTPverF extends ConsumerWidget {
  const OTPverF ({super.key});

 void sendDataToBackend(BuildContext context, String pin) async {

    const String apiUrl = 'https://backend-api-for-verifation.com/';

    final Map<String, dynamic> requestBody = {
      'otp': pin,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('OTP verification successful'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        
      } else {
        _showErrorDialog(context, 'Failed to verify OTP: ${response.reasonPhrase}');
      }
    } catch (error) {
      _showErrorDialog(context, 'Failed to verify OTP: $error');
    }
  }

void navigateToPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfilePage()), 
  );
}


  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(fontWeight: FontWeight.bold), 
            selectionColor: Color.fromARGB(0, 248, 3, 3),
          ),
          content: Text(message),
          backgroundColor: const Color.fromARGB(255, 214, 204, 204),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph =  ref.watch(phoneNumberProvider);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromARGB(255, 239, 237, 237),
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 72, 62, 120),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: const Text(''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "Verification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const Text(
                  "Enter the code sent to your number",
                  style: TextStyle(
                    color: Color.fromARGB(255, 90, 101, 171),
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  ph.text,
                  style:const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              Pinput(
                length: 5,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Color.fromARGB(255, 201, 198, 207)),
                  ),
                ),
                onCompleted: (pin) => sendDataToBackend(context, pin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}