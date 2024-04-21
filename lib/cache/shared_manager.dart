import 'package:phone_book/cache/shared_not_initialize_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys { key, people }

class SharedManager {
  SharedPreferences? preferences;

  //When SahredManager class call, this function will run
  SharedManager() {
    init();
  }

  //Define sharedPreferences
  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  //if preferences null throw user defined exception (shared_not_initialized_exception.dart file)
  void _checkPreferences() {
    if (preferences == null) {
      throw SharedNotInitializedException();
    }
  }

  //Check whether the preferences are null or not. If the preferences is not null, the values are saved as a list.
  Future<void> saveDataList(SharedKeys key, List<String> value) async {
    _checkPreferences();
    await preferences?.setStringList(key.name, value);
  }

  //It provide get data(s) from List.
  List<String>? getDataList(SharedKeys key) {
    _checkPreferences();
    return preferences?.getStringList(key.name);
  }

  Future<void> clearData() async {
    await preferences?.clear();
  }
}
