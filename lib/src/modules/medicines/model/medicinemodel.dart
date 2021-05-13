import 'package:hive/hive.dart';

part 'medicinemodel.g.dart';

@HiveType(typeId: 1)
@HiveType()
class MedicineModel {
  @HiveField(0)
  String medicineName;
  @HiveField(1)
  String dosage;
  @HiveField(2)
  String medicineUnit;
  @HiveField(3)
  String medicineFrequency;
  @HiveField(4)
  String medicineNote;

  MedicineModel(this.medicineName, this.dosage, this.medicineUnit,
      this.medicineFrequency, this.medicineNote);
}
