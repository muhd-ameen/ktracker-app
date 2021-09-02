// To parse this JSON data, do
//
//     final summaryData = summaryDataFromJson(jsonString);

import 'dart:convert';

class SummaryData {
  SummaryData({
    this.summary,
    this.delta,
    this.lastUpdated,
  });

  Delta summary;
  Delta delta;
  String lastUpdated;

  factory SummaryData.fromRawJson(String str) => SummaryData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryData.fromJson(Map<String, dynamic> json) => SummaryData(
    summary: Delta.fromJson(json["summary"]),
    delta: Delta.fromJson(json["delta"]),
    lastUpdated: json["last_updated"],
  );

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "delta": delta.toJson(),
    "last_updated": lastUpdated,
  };
}

class Delta {
  Delta({
    this.confirmed,
    this.recovered,
    this.active,
    this.deceased,
    this.totalObs,
    this.hospitalObs,
    this.homeObs,
    this.hospitalToday,
  });

  int confirmed;
  int recovered;
  int active;
  int deceased;
  int totalObs;
  int hospitalObs;
  int homeObs;
  int hospitalToday;

  factory Delta.fromRawJson(String str) => Delta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Delta.fromJson(Map<String, dynamic> json) => Delta(
    confirmed: json["confirmed"],
    recovered: json["recovered"],
    active: json["active"],
    deceased: json["deceased"],
    totalObs: json["total_obs"],
    hospitalObs: json["hospital_obs"],
    homeObs: json["home_obs"],
    hospitalToday: json["hospital_today"],
  );

  Map<String, dynamic> toJson() => {
    "confirmed": confirmed,
    "recovered": recovered,
    "active": active,
    "deceased": deceased,
    "total_obs": totalObs,
    "hospital_obs": hospitalObs,
    "home_obs": homeObs,
    "hospital_today": hospitalToday,
  };
}
