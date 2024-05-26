import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/models/user.dart';
import 'package:hive/hive.dart';



class LoginState {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isLoading;

  LoginState({
    required this.usernameController,
    required this.passwordController,
    required this.isLoading,
  });

  factory LoginState.initial() {
    return LoginState(
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
      isLoading: false,
    );
  }

  LoginState copyWith({
    TextEditingController? usernameController,
    TextEditingController? passwordController,
    bool? isLoading,
  }) {
    return LoginState(
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class Logink {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog(context, 'Please enter username and password');
      return;
    }

    try {
      final Uri loginUri = Uri.parse('http- back-end endpoint');

      final http.Response response = await http.post(
        loginUri,
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String accessToken = responseData['accessToken'];
        final String refreshToken = responseData['refreshToken'];

        
        await saveTokensToHive(accessToken, refreshToken);

      
        await saveCredentialsToHive(username, password);

       
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showErrorDialog(context, 'Failed to login: ${response.reasonPhrase}');
      }
    } catch (error) {
      _showErrorDialog(context, 'Failed to login: $error');
    }
  }

  Future<void> saveTokensToHive(String accessToken, String refreshToken) async {
    final box = await Hive.openBox('user');
    await box.put('accessToken', accessToken);
    await box.put('refreshToken', refreshToken);
  }

  Future<void> saveCredentialsToHive(String username, String password) async {
    final loginBox = await Hive.openBox<User>('user');
    final login = User()
      ..username = username
      ..password = password;

    await loginBox.put('login', login);
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
// void navigateToPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => HomePage()), 
//   );
// }

class LoginPage extends StatelessWidget {
  final Logink _loginController = Logink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 52, 41, 82),
                  Color(0xff281537),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Welcome\n Back!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top:20 ,left: 30.0, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const SizedBox(height: 20),
                    TextField(
                      controller: _loginController.usernameController,
                      decoration:  InputDecoration(
                         border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0), 
                                 ),
                        suffixIcon:const Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        labelText: 'User name',
                        labelStyle:const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 151, 143, 144),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _loginController.passwordController,
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
                   const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                       child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');// forgot password page ??
                            },
                            child:const Text(
                              "Forgot password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                    ),
                    const SizedBox(height: 70),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 52, 41, 82),
                            Color(0xff281537),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                         onPressed: () => Navigator.pushNamed(context, '/home'),//_loginController.login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        
                        ),
                      ),
                    ),
                  const SizedBox(height: 100),
                     Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
