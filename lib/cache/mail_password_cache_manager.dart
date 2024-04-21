import 'dart:convert';

import 'package:phone_book/cache/mail_password_model.dart';
import 'package:phone_book/cache/shared_manager.dart';

class MailPasswordCacheManager {
  final SharedManager sharedManager;

  MailPasswordCacheManager({required this.sharedManager});
  //This function defines the process of converting a list into JSON format and then saving this JSON data into a local storage mechanism, using shared preferences
  Future<void> saveData(final List<MailPasswordModel> items) async {
    final _items = items.map((e) => jsonEncode(e.toJson())).toList();
    await sharedManager.saveDataList(SharedKeys.people, _items);
  }

  //It retrieves data from the shared preferences list in JSON format, converts it into MailPasswordModel objects, and returns a list of these objects.
  List<MailPasswordModel>? getData() {
    final itemStringList = sharedManager.getDataList(SharedKeys.people);

    if (itemStringList?.isNotEmpty ?? false) {
      return itemStringList!.map((e) {
        final jsonObject = jsonDecode(e);
        if (jsonObject is Map<String, dynamic>) {
          return MailPasswordModel.fromJson(jsonObject);
        }
        return MailPasswordModel(
            mail: 'Error', password: "Data not found. Codes has some issues");
      }).toList();
    }
  }

  Future<void> clearMailAndPassword() async {
    await sharedManager.clearData();
  }
}
