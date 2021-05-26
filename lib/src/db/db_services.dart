import 'package:hive/hive.dart';
import 'package:mobile_app/src/modules/logs/model/logsmodel.dart';
import 'package:mobile_app/src/utilities/strings.dart';
import 'package:mobile_app/src/globals.dart' as globals;

class DbServices {
  // add Data using this method
  Future<bool> addData(model, tableName) async {
    try {
      final hiveBox = await Hive.openBox(tableName);
      hiveBox.add(model);

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
      var hiveBox = await Hive.openBox(tableName);
      var list = hiveBox.values.toList();
      return list;
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("NO_CONNECTION");
      } else {
        throw (e);
      }
    }
  }

  Future<List> getSelectedDateData(tableName) async {
    try {
      var hiveBox = await Hive.openBox(tableName);
      var list = hiveBox.values.toList();
      List<LogsModel> listofSelectedDate;
      listofSelectedDate = new List();

      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          // print(logsList[i].dateTime);

          String logTemp1 = "${list[i].dateTime}".split(' ')[0];
          String logTemp2 = "${globals.getdatefromslider}".split(' ')[0];

          if (logTemp1 == logTemp2) {
            // DateTime dateTime = logsList[i].dateTime;
            // String position;
            // String temprature;
            // String symptoms;
            // var addMedinceLog;
            // String addNotehere;
            var item = LogsModel(
                list[i].dateTime,
                list[i].position,
                list[i].temprature,
                list[i].symptoms,
                list[i].addMedinceLog,
                list[i].addNotehere);

            listofSelectedDate.add(item);

            // var filteredUsers = logsList.values
            //     .where((LogsModel) => LogsModel.dateTime == "")
            //     .toList();
            // print(filteredUsers.length);
          }
        }
      }

      return listofSelectedDate;
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("NO_CONNECTION");
      } else {
        throw (e);
      }
    }
  }

  Future<bool> updateListData(tableName, index, value) async {
    try {
      final hiveBox = await Hive.openBox(tableName);

      hiveBox.putAt(index, value);

      return true;
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("NO_CONNECTION");
      } else {
        throw (e);
      }
    }
  }

  Future<bool> deleteData(tableName, index) async {
    try {
      final hiveBox = await Hive.openBox(tableName);
      hiveBox.deleteAt(index);

      return true;
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw ("NO_CONNECTION");
      } else {
        throw (e);
      }
    }
  }
}
