import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/profilemo.dart';
import 'package:test/providers/profileprovider.dart';



class ProfilePage extends ConsumerStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _locationController;
  late TextEditingController _emailController;
   File? _imageFile;
    bool _formEdited = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _firstnameController = TextEditingController(text: profile?.firstname ?? '');
    _lastnameController = TextEditingController(text: profile?.lastname ?? '');
    _locationController = TextEditingController(text: profile?.location ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');
    ref.read(profileProvider.notifier).fetchProfile();
  }

@override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);

    if (profile == null) {
      // return Scaffold(
      //   appBar: AppBar(title: Text('Profile')),
      //   body: Center(child: CircularProgressIndicator()),
      // );
return Scaffold(
      appBar: AppBar(title: const Text('MY Profile',style: TextStyle(
      fontWeight: FontWeight.bold, 
    ),)),
      body:Form(
        key: _formKey,
         onChanged: () {
          setState(() {
            _formEdited = true;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              GestureDetector(
                   onTap: _getImageFromGallery,
                   child: CircleAvatar(
                     radius: 50,
                     backgroundImage: _imageFile != null
                         ? FileImage(_imageFile!)
                         
                         : (profile?.imageUrl != null 
                             ? NetworkImage(profile!.imageUrl) 
                             : AssetImage('lib/images/add_image.png')) as ImageProvider<Object>?,
                   ),
                 ),
              SizedBox(height: 20),
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your firstname';
                  }
                  return null;
                },
              ),
                            SizedBox(height: 20),

              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your lastname';
                  }
                  return null;
                },
              ),
                            SizedBox(height: 20),

              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration:  InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
           ElevatedButton(
         onPressed: _formEdited
      ? () {
          if (_formKey.currentState!.validate()) {
            final updatedProfile = Profile(
              firstname: _firstnameController.text,
              lastname: _lastnameController.text,
              location: _locationController.text,
              email: _emailController.text,
              imageUrl: profile!.imageUrl,
            );
            ref.read(profileProvider.notifier).updateProfile(updatedProfile);
          }
        }
                  : null, 
            style: ElevatedButton.styleFrom(
              backgroundColor: _formEdited ?  Color.fromARGB(255, 35, 18, 48) : Colors.grey, 
              foregroundColor: Colors.white, 
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), 
              ),
              elevation: 5.0, 
            ),
            child: const Text(
              'Update',
              style: TextStyle(
                fontSize: 16.0, // Text size
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

    return Scaffold(
      appBar: AppBar(title: const Text('MY Profile',style: TextStyle(
      fontWeight: FontWeight.bold, 
    ),)),
      body:Form(
        key: _formKey,
         onChanged: () {
          setState(() {
            _formEdited = true;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              GestureDetector(
                   onTap: _getImageFromGallery,
                   child: CircleAvatar(
                     radius: 50,
                     backgroundImage: _imageFile != null
                         ? FileImage(_imageFile!)
                         
                         : (profile?.imageUrl != null 
                             ? NetworkImage(profile!.imageUrl!) 
                             : AssetImage('lib/images/add_image.png')) as ImageProvider<Object>?,
                   ),
                 ),
              SizedBox(height: 20),
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your firstname';
                  }
                  return null;
                },
              ),
                            SizedBox(height: 20),

              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your lastname';
                  }
                  return null;
                },
              ),
                            SizedBox(height: 20),

              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
                            SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration:  InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
                       ElevatedButton(
              onPressed: _formEdited
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        final updatedProfile = Profile(
                          firstname: _firstnameController.text,
                          lastname: _lastnameController.text,
                          location: _locationController.text,
                          email: _emailController.text,
                          imageUrl: profile.imageUrl,
                        );
                        ref.read(profileProvider.notifier).updateProfile(updatedProfile);
                      }
                    }
                  : null, 
              style: ElevatedButton.styleFrom(
                backgroundColor: _formEdited ?  Color.fromARGB(255, 35, 18, 48) : Colors.grey, 
                foregroundColor: Colors.white, 
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
  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }
}

 
