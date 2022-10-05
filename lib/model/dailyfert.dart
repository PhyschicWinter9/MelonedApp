class DailyFert {
  DailyFert(this.fertname, this.fertamount);

  final String fertname;
  final double fertamount;

  DailyFert.fromJson(Map<String, dynamic> json)
      : fertname = json['fert_name'],
        fertamount = json['fert_amount'];
}