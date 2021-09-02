// To parse this JSON data, do
//
//     final districtWise = districtWiseFromJson(jsonString);

import 'dart:convert';

class DistrictWise {
  DistrictWise({
    this.summary,
    this.delta,
    this.lastUpdated,
  });

  Delta summary;
  Delta delta;
  String lastUpdated;

  factory DistrictWise.fromRawJson(String str) => DistrictWise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistrictWise.fromJson(Map<String, dynamic> json) => DistrictWise(
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
    this.thiruvananthapuram,
    this.kollam,
    this.pathanamthitta,
    this.alappuzha,
    this.kottayam,
    this.idukki,
    this.ernakulam,
    this.thrissur,
    this.palakkad,
    this.malappuram,
    this.kozhikode,
    this.wayanad,
    this.kannur,
    this.kasaragod,
  });

  Alappuzha thiruvananthapuram;
  Alappuzha kollam;
  Alappuzha pathanamthitta;
  Alappuzha alappuzha;
  Alappuzha kottayam;
  Alappuzha idukki;
  Alappuzha ernakulam;
  Alappuzha thrissur;
  Alappuzha palakkad;
  Alappuzha malappuram;
  Alappuzha kozhikode;
  Alappuzha wayanad;
  Alappuzha kannur;
  Alappuzha kasaragod;

  factory Delta.fromRawJson(String str) => Delta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Delta.fromJson(Map<String, dynamic> json) => Delta(
    thiruvananthapuram: Alappuzha.fromJson(json["Thiruvananthapuram"]),
    kollam: Alappuzha.fromJson(json["Kollam"]),
    pathanamthitta: Alappuzha.fromJson(json["Pathanamthitta"]),
    alappuzha: Alappuzha.fromJson(json["Alappuzha"]),
    kottayam: Alappuzha.fromJson(json["Kottayam"]),
    idukki: Alappuzha.fromJson(json["Idukki"]),
    ernakulam: Alappuzha.fromJson(json["Ernakulam"]),
    thrissur: Alappuzha.fromJson(json["Thrissur"]),
    palakkad: Alappuzha.fromJson(json["Palakkad"]),
    malappuram: Alappuzha.fromJson(json["Malappuram"]),
    kozhikode: Alappuzha.fromJson(json["Kozhikode"]),
    wayanad: Alappuzha.fromJson(json["Wayanad"]),
    kannur: Alappuzha.fromJson(json["Kannur"]),
    kasaragod: Alappuzha.fromJson(json["Kasaragod"]),
  );

  Map<String, dynamic> toJson() => {
    "Thiruvananthapuram": thiruvananthapuram.toJson(),
    "Kollam": kollam.toJson(),
    "Pathanamthitta": pathanamthitta.toJson(),
    "Alappuzha": alappuzha.toJson(),
    "Kottayam": kottayam.toJson(),
    "Idukki": idukki.toJson(),
    "Ernakulam": ernakulam.toJson(),
    "Thrissur": thrissur.toJson(),
    "Palakkad": palakkad.toJson(),
    "Malappuram": malappuram.toJson(),
    "Kozhikode": kozhikode.toJson(),
    "Wayanad": wayanad.toJson(),
    "Kannur": kannur.toJson(),
    "Kasaragod": kasaragod.toJson(),
  };
}

class Alappuzha {
  Alappuzha({
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

  factory Alappuzha.fromRawJson(String str) => Alappuzha.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alappuzha.fromJson(Map<String, dynamic> json) => Alappuzha(
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
