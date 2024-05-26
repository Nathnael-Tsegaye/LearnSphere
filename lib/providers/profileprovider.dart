import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test/models/profilemo.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, Profile?>((ref) => ProfileNotifier());

class ProfileNotifier extends StateNotifier<Profile?> {
  ProfileNotifier() : super(null);

  Future<void> fetchProfile() async {
    final response = await http.get(Uri.parse('https://api.back-end-fr-profile'));
    if (response.statusCode == 200) {
      state = Profile.fromJson(jsonDecode(response.body));
    } else {
       throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfile(Profile profile) async {
    final response = await http.post(
      Uri.parse('https://api.back-end-for-updating-profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(profile.toJson()),
    );
    if (response.statusCode == 200) {
      state = profile;
    } else {
       throw Exception('Failed to update profile'); 
    }
  }
}