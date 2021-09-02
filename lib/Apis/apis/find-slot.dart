// To parse this JSON data, do
//
//     final findVaccineCenter = findVaccineCenterFromJson(jsonString);

import 'dart:convert';

class FindVaccineCenter {
  FindVaccineCenter({
    this.sessions,
  });

  List<Session> sessions;

  factory FindVaccineCenter.fromRawJson(String str) => FindVaccineCenter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FindVaccineCenter.fromJson(Map<String, dynamic> json) => FindVaccineCenter(
    sessions: List<Session>.from(json["sessions"].map((x) => Session.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
  };
}

class Session {
  Session({
    this.centerId,
    this.name,
    this.address,
    this.stateName,
    this.districtName,
    this.blockName,
    this.pincode,
    this.from,
    this.to,
    this.lat,
    this.long,
    this.feeType,
    this.sessionId,
    this.date,
    this.availableCapacity,
    this.availableCapacityDose1,
    this.availableCapacityDose2,
    this.fee,
    this.minAgeLimit,
    this.vaccine,
    this.slots,
  });

  int centerId;
  String name;
  String address;
  String stateName;
  String districtName;
  String blockName;
  int pincode;
  String from;
  String to;
  int lat;
  int long;
  String feeType;
  String sessionId;
  String date;
  int availableCapacity;
  int availableCapacityDose1;
  int availableCapacityDose2;
  String fee;
  int minAgeLimit;
  String vaccine;
  List<String> slots;

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    centerId: json["center_id"],
    name: json["name"],
    address: json["address"],
    stateName: json["state_name"],
    districtName: json["district_name"],
    blockName: json["block_name"],
    pincode: json["pincode"],
    from: json["from"],
    to: json["to"],
    lat: json["lat"],
    long: json["long"],
    feeType: json["fee_type"],
    sessionId: json["session_id"],
    date: json["date"],
    availableCapacity: json["available_capacity"],
    availableCapacityDose1: json["available_capacity_dose1"],
    availableCapacityDose2: json["available_capacity_dose2"],
    fee: json["fee"],
    minAgeLimit: json["min_age_limit"],
    vaccine: json["vaccine"],
    slots: List<String>.from(json["slots"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "center_id": centerId,
    "name": name,
    "address": address,
    "state_name": stateName,
    "district_name": districtName,
    "block_name": blockName,
    "pincode": pincode,
    "from": from,
    "to": to,
    "lat": lat,
    "long": long,
    "fee_type": feeType,
    "session_id": sessionId,
    "date": date,
    "available_capacity": availableCapacity,
    "available_capacity_dose1": availableCapacityDose1,
    "available_capacity_dose2": availableCapacityDose2,
    "fee": fee,
    "min_age_limit": minAgeLimit,
    "vaccine": vaccine,
    "slots": List<dynamic>.from(slots.map((x) => x)),
  };
}
