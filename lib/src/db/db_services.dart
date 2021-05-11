import 'package:hive/hive.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/utilities/strings.dart';

class DbServices {
  // add Data using this method
  Future<bool> addData(model, tableName) async {
    try {
      final hiveBox = await Hive.openBox(Strings.hiveLogName);
      hiveBox.add(model);
      // hiveBox.put(Strings.hiveLogName, model);

      return true;
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("NO_CONNECTION");
      } else {
        throw (e);
      }
    }
  }

  // get List Object using this method
  Future<List> getListData(tableName) async {
    try {
      var hiveBox = await Hive.openBox(Strings.hiveLogName);
      var list = hiveBox.values.toList();
      print(list.length);
      return list;
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("NO_CONNECTION");
      } else {
        throw (e);
      }
    }
  }
}
