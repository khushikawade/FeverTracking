import 'package:hive/hive.dart';

part 'profilemodel.g.dart';

@HiveType(typeId: 4)
@HiveType()
class ProfileModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int phonenumber;
  @HiveField(2)
  int age;
  @HiveField(3)
  String gender;
  @HiveField(4)
  ProfileModel(
    this.name,
    this.phonenumber,
    this.age,
    this.gender,
  );
}
