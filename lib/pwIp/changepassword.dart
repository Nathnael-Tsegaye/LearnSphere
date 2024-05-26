import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

    

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _formEdited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          onChanged: () {
          setState(() {
            _formEdited = true;
          });
        },
          child: Column(
            children: [
              TextFormField(
                controller: _newPasswordController,
               decoration: InputDecoration(
                  labelText: ' New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
               decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Update the password
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password updated successfully')),
                    );
                    Navigator.pop(context);
                  }
                },
                 style: ElevatedButton.styleFrom(
                backgroundColor: _formEdited ?  Color.fromARGB(255, 35, 18, 48) : Colors.grey,
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), 
                ),
                elevation: 5.0, 
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 16.0, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
