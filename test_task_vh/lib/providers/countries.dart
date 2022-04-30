// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_task_vh/models/country.dart';

class Countries with ChangeNotifier {
  List<Country>? _countries = [];
  List<Country>? searchResult = [];
  Country? country;

  List<Country> get countries {
    return [...?_countries];
  }

  String get defCode {
    return _countries![0].code;
  }

  String get defFlag {
    return _countries![0].flagUrl;
  }

  Future<void> fetchAndSetCountries() async {
    final url = Uri.parse('https://restcountries.com/v2/all');
    try {
      final responce = await http.get(url);
      final List<Country> loadedCountries = [];
      final extractedData = json.decode(responce.body) as List<dynamic>?;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((element) {
        loadedCountries.add(
          Country(
            country: element['name'],
            code: '+' + element['callingCodes'][0],
            flagUrl: element['flag'],
          ),
        );
      });
      _countries = loadedCountries;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void search(String searchText) {
    searchResult!.clear();
    for (int i = 0; i < _countries!.length; i++) {
      String data = _countries![i].country;
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        searchResult!.add(_countries![i]);
      }
    }
    notifyListeners();
  }
}
