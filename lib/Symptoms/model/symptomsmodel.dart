import 'package:hive/hive.dart';

// part 'symptomsmodel.g.dart';

@HiveType(typeId: 2)
@HiveType()
class SymptomsModel {
  @HiveField(0)
  String symptomName;

  // @HiveField(3)
  // String addMedinceLog;
  // @HiveField(4)
  // String addNotehere;
  SymptomsModel(this.symptomName);
}
