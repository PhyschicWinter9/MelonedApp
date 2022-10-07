class DailyFertModel {
  String? fertname;
  double? fertamount;

  DailyFertModel({
    this.fertname,
    this.fertamount,
  });

  DailyFertModel.fromJson(Map<String, dynamic> json) {
    fertname = json['fert_name'];
    fertamount = json['ferting_amount'];
  }
}
