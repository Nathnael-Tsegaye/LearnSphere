import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/Course.dart';
import '../models/grid_view.dart'; 
import '../models/WhatsNewMo.dart'; 
import '../models/CatagoryMo.dart'; 





final courseprovider = FutureProvider<List<Coursemodel>>(
  (ref) async {
    final response = await http.get(Uri.parse('https://api.course.com/data')); 
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Coursemodel> courses = data.map((item) {
        return Coursemodel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return courses;
    } else {
      throw Exception('Failed to load data');
    }
  },
);




final populardprovider = FutureProvider<List<PopularModel>>(
  (ref) async {
    final response = await http.get(Uri.parse('https://api.popular.com/data')); 
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<PopularModel> imageTitlePairs = data.map((item) {
        return PopularModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return imageTitlePairs;
    } else {
      throw Exception('Failed to load data');
    }
  },
);



final whatsnewdprovider = FutureProvider<List<WhatsnewModel>>(
  (ref) async {
    final response = await http.get(Uri.parse('https://api.whatsn.com/data')); 
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<WhatsnewModel> imageTitlePairs = data.map((item) {
        return WhatsnewModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return imageTitlePairs;
    } else {
      throw Exception('Failed to load data');
    }
  },
);

final catagorydprovider = FutureProvider<List<CategoryModel>>(
  (ref) async {
    final response = await http.get(Uri.parse('https://api.catagory.com/data')); 
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<CategoryModel> imageTitlePairs = data.map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return imageTitlePairs;
    } else {
      throw Exception('Failed to load data');
    }
  },
);

