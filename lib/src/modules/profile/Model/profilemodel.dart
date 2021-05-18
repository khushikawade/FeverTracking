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
  String imageName;
  @HiveField(5)
  String path;
  @HiveField(6)
  String address;
  ProfileModel(
    this.name,
    this.address,
    this.phonenumber,
    this.age,
    this.gender,
    this.imageName,
    this.path,
  );
}
