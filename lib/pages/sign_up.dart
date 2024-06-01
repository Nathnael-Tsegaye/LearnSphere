import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/pages/otp_verification.dart';
import 'dart:convert'; 


final firstNameProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final lastNameProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final confirmPasswordProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final emailProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final phoneNumberProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final locationProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final accountTypeProvider = StateProvider<String>((ref) {
  return 'Student'; 
});



class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: SignUpPageContent(),
    );
  }
}

class SignUpPageContent extends ConsumerWidget {



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final firstNameController = ref.watch(firstNameProvider);
    final lastNameController =  ref.watch(lastNameProvider);
    final passwordController =  ref.watch(passwordProvider);
    final confirmPasswordController =  ref.watch(confirmPasswordProvider);
    final emailController =  ref.watch(emailProvider);
    final phoneNumberController =  ref.watch(phoneNumberProvider);
    final locationController =  ref.watch(locationProvider);
    final accountType =  ref.read(accountTypeProvider);
    
    

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 102, 98, 99),
                  Color(0xff281537),
                ],
              ),
            ),
            child: ListView(
              
              children: [
               const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 22),
                  child: Text(
                    'Create\nAn  Account !',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0 ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only( left: 40.0, right: 40.0, bottom: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                           const SizedBox(height: 30),
                            TextField(
                              controller: firstNameController,
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                labelText: 'First Name',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 151, 143, 144),
                                ),
                              ),
                            ),
                          const  SizedBox(height: 20),
                            TextField(
                              controller: lastNameController,
                              decoration:  InputDecoration(
                                 border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                labelText: 'Last Name',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 122, 116, 117),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const Text(
                                  'Account Type:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 122, 116, 117),
                                  ),
                                ),
                               
                              const SizedBox(width: 15),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Student',
                                    groupValue: accountType,
                                    onChanged: (value)=>  ref.read(accountType as ProviderListenable).state = value!,

                                    
                                  ),
                                  const Text('Student'),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Teacher',
                                    groupValue: accountType,
                                    
                                    onChanged: (value)=>  ref.read(accountType as ProviderListenable).state = value!,

                                   
                                  ),
                                  const Text('Teacher'),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Admin',
                                   groupValue: accountType,
                                    onChanged: (value)=>  ref.read(accountType as ProviderListenable).state = value!,


                                    
                                  ),
                                  const Text('Admin'),
                                ],
                              ),
                            
                          
                              ],
                            ),
                         const SizedBox(height: 20),
                            TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:  InputDecoration(
                               border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                              suffixIcon:const Icon(
                                Icons.mail,
                                color: Colors.grey,
                              ),
                              labelText: 'email',
                              labelStyle:const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 122, 116, 117),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration:  InputDecoration(
                               border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                              suffixIcon:const Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                              labelText: 'Phone Number',
                              labelStyle:const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 122, 116, 117),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: locationController,
                            decoration:  InputDecoration(
                               border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                              suffixIcon:const Icon(
                                Icons.location_city,
                                color: Colors.grey,
                              ),
                              labelText: 'Address (Optional)',
                              labelStyle:const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 122, 116, 117),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration:  InputDecoration(
                               border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                              suffixIcon:const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              labelText: 'Password',
                              labelStyle:const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 122, 116, 117),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration:  InputDecoration(
                               border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                              suffixIcon:const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              labelText: 'Confirm Password',
                              labelStyle:const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 231, 72, 98),
                              ),
                            ),
                          ),
                           const SizedBox(height: 40,),
                            Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 151, 152, 157),
                                    Color(0xff281537),
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () => _registerUser(context,ref),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                ),
                                child: const Text(
                                  'sign up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

void na(BuildContext context,WidgetRef ref) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OTPverF()),
  );
}


   Future<void> _registerUser(BuildContext context, WidgetRef ref) async {
  final firstname = ref.read(firstNameProvider).text;
  final lastname = ref.read(lastNameProvider).text;
  final passWord = ref.read(passwordProvider).text;
  final confirmpassWord = ref.read(confirmPasswordProvider).text;
  final email = ref.read(emailProvider).text;
  final phone_number = ref.read(phoneNumberProvider).text;
  final location = ref.read(locationProvider).text;
  final accountType = ref.read(accountTypeProvider);

  if (firstname.isEmpty ||
      lastname.isEmpty ||
      passWord.isEmpty ||
      confirmpassWord.isEmpty ||
      email.isEmpty ||
      phone_number.isEmpty) {
    _showErrorDialog(context, 'Please fill in all required fields');
    return;
  }

  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    _showErrorDialog(context, 'Email address is invalid');
    return;
  }

 try {
  final response = await http.post(
    Uri.parse('https://vkrnzh7v-8000.euw.devtunnels.ms/api/register'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'password': passWord,
      'password_confirmation': confirmpassWord,
    }),
  );

  if (response.statusCode == 200) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    if (response.statusCode == 400) {
      _showErrorDialog(context, 'Bad Request: Please check your input.');
    } else if (response.statusCode == 401) {
      _showErrorDialog(context, 'Unauthorized: Invalid credentials.');
    } else if (response.statusCode == 409) {
      _showErrorDialog(context, 'Conflict: User already exists.'); 
    } else if (response.statusCode >= 500) {
      _showErrorDialog(context, 'Internal Server Error: Please try again later.');
    } else {
      _showErrorDialog(context, 'Failed to register user. Please try again. (Error code: ${response.statusCode})');
    }
  }
} on SocketException catch (e) {
  _showErrorDialog(context, 'Network error. Please check your connection and try again.');
} catch (error) {
  print('Error registering user: $error');
  _showErrorDialog(context, 'An unexpected error occurred. Please try again.');
}
   }

   
void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(fontWeight: FontWeight.bold), 
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
}
