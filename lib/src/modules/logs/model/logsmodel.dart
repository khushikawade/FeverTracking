import 'package:hive/hive.dart';

// part 'contact.g.dart';

@HiveType()
class LogsModel {
  @HiveField(0)
  String dateTime;
  @HiveField(1)
  String position;
  @HiveField(2)
  String temprature;
  @HiveField(3)
  String symptoms;
  // @HiveField(3)
  // String addMedinceLog;
  // @HiveField(4)
  // String addNotehere;
  LogsModel(this.position, this.temprature, this.symptoms);
}
