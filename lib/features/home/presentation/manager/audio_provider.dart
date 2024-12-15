
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioProvider with ChangeNotifier {
  List<String> _audioPaths = []; // Saqlangan audio fayllar

  List<String> get audioPaths => _audioPaths;

  // Audio fayl qo'shish
  Future<void> addAudio(String path) async {
    _audioPaths.add(path);
    notifyListeners();
    await _saveToLocalStorage(); // Saqlash
  }

  // Audio faylni o'chirish
  Future<void> removeAudio(String path) async {
    _audioPaths.remove(path);
    notifyListeners();
    await _saveToLocalStorage(); // Yangilash
  }

  // Fayllarni yuklash
  Future<void> loadAudios() async {
    final prefs = await SharedPreferences.getInstance();
    _audioPaths = prefs.getStringList('audioPaths') ?? [];
    notifyListeners();
  }

  // Fayllarni local storage'ga saqlash
  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('audioPaths', _audioPaths);
  }
}
