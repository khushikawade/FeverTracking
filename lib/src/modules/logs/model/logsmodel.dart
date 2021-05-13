import 'package:hive/hive.dart';

part 'logsmodel.g.dart';

@HiveType(typeId: 0)
@HiveType()
class LogsModel {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  String position;
  @HiveField(2)
  String temprature;
  @HiveField(3)
  String symptoms;
  // @HiveField(3)
  // String addMedinceLog;
  @HiveField(4)
  String addNotehere;
  LogsModel(this.dateTime, this.position, this.temprature, this.symptoms,
      this.addNotehere);
}
