// To parse this JSON data, do
//
//     final vaccineData = vaccineDataFromJson(jsonString);

import 'dart:convert';

class VaccineData {
  VaccineData({
    this.summary,
    this.delta,
    this.lastUpdated,
  });

  Delta summary;
  Delta delta;
  String lastUpdated;

  factory VaccineData.fromRawJson(String str) => VaccineData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VaccineData.fromJson(Map<String, dynamic> json) => VaccineData(
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
    this.cvcPublic,
    this.cvcPrivate,
    this.cvcTotal,
    this.hcwDose1,
    this.hcwDose2,
    this.flwOtherDose1,
    this.flwOtherDose2,
    this.flwPollingDose1,
    this.flwPollingDose2,
    this.ageAppropriateDose1,
    this.ageAppropriateDose2,
    this.totVaccinations,
    this.totPersonVaccinations,
    this.secondDose,
  });

  int cvcPublic;
  int cvcPrivate;
  int cvcTotal;
  int hcwDose1;
  int hcwDose2;
  int flwOtherDose1;
  int flwOtherDose2;
  int flwPollingDose1;
  int flwPollingDose2;
  int ageAppropriateDose1;
  int ageAppropriateDose2;
  int totVaccinations;
  int totPersonVaccinations;
  int secondDose;

  factory Delta.fromRawJson(String str) => Delta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Delta.fromJson(Map<String, dynamic> json) => Delta(
    cvcPublic: json["cvc_public"],
    cvcPrivate: json["cvc_private"],
    cvcTotal: json["cvc_total"],
    hcwDose1: json["hcw_dose1"],
    hcwDose2: json["hcw_dose2"],
    flwOtherDose1: json["flw_other_dose1"],
    flwOtherDose2: json["flw_other_dose2"],
    flwPollingDose1: json["flw_polling_dose1"],
    flwPollingDose2: json["flw_polling_dose2"],
    ageAppropriateDose1: json["age_appropriate_dose1"],
    ageAppropriateDose2: json["age_appropriate_dose2"],
    totVaccinations: json["tot_vaccinations"],
    totPersonVaccinations: json["tot_person_vaccinations"],
    secondDose: json["second_dose"],
  );

  Map<String, dynamic> toJson() => {
    "cvc_public": cvcPublic,
    "cvc_private": cvcPrivate,
    "cvc_total": cvcTotal,
    "hcw_dose1": hcwDose1,
    "hcw_dose2": hcwDose2,
    "flw_other_dose1": flwOtherDose1,
    "flw_other_dose2": flwOtherDose2,
    "flw_polling_dose1": flwPollingDose1,
    "flw_polling_dose2": flwPollingDose2,
    "age_appropriate_dose1": ageAppropriateDose1,
    "age_appropriate_dose2": ageAppropriateDose2,
    "tot_vaccinations": totVaccinations,
    "tot_person_vaccinations": totPersonVaccinations,
    "second_dose": secondDose,
  };
}
