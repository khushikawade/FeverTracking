class CheckBoxModel {
  String id;
  String displayId;
  bool checked;

  CheckBoxModel({
    this.id,
    this.displayId,
    this.checked,
  });

  factory CheckBoxModel.fromJson(Map<String, dynamic> json) => CheckBoxModel(
        id: json["id"] == null ? null : json["id"],
        displayId: json["displayId"] == null ? null : json["displayId"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "displayId": displayId == null ? null : displayId,
        "checked": checked == null ? null : checked,
      };
}
