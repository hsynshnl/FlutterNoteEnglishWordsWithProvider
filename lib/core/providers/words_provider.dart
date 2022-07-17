import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordsProvider with ChangeNotifier {
  List<String> _turkishWord = [];
  List<String> _englishWord = [];
  List get english => _englishWord;
  List get turkish => _turkishWord;
  void _setPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('english_list', _englishWord);
    pref.setStringList('turkish_list', _turkishWord);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _englishWord = pref.getStringList('english_list') ?? [];
    _turkishWord = pref.getStringList('turkish_list') ?? [];

    notifyListeners();
  }

  void addWord(String turkish, String english) {
    _englishWord.add(english);
    _turkishWord.add(turkish);
    _setPrefItems();
    notifyListeners();
  }

  int getListLenght() {
    _getPrefItems();
    return _turkishWord.length;
  }

  void deleteWord(int index) {
    _turkishWord.removeAt(index);
    _englishWord.removeAt(index);
    _setPrefItems();
    notifyListeners();
  }

  void editWord(int index, String english, String turkish) {
    _englishWord.removeAt(index);
    _englishWord.insert(index, english);

    _turkishWord.removeAt(index);
    _turkishWord.insert(index, turkish);
    _setPrefItems();
    notifyListeners();
  }
}
