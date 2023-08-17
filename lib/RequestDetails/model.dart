// To parse this JSON data, do
//
//     final requestUserDetails = requestUserDetailsFromJson(jsonString);

import 'dart:convert';

//model to convert api into requested user details

class RequestUserDetails {
  bool success;
  Ticket ticket;

  RequestUserDetails({
    required this.success,
    required this.ticket,
  });

  factory RequestUserDetails.fromJson(Map<String, dynamic> json) {
    return RequestUserDetails(
      success: json["success"],
      ticket: Ticket.fromJson(json["ticket"]),
    );
  }
}

class Ticket {
  //Location currentLocation;
  //Location trackingLocation;
  String id;
  int customerUid;
  //dynamic mechanicUid;
  String scheduleOfService;
  //List<dynamic> typesOfServices;
  //List<dynamic> query;
  String status;
  String paymentMode;
  String paymentStatus;
  bool isVerifiedOnTimeOtp;
  bool isVerifiedscheduledArrivedOtp;
  bool isVerifiedscheduledWorkshopOtp;
  bool isVerifiedscheduledDeliveredOtp;
  DateTime createdAt;
  DateTime updatedAt;
  String onTimeOtp;
  int v;
  CustomerId customerId;
  MechanicId mechanicId;
  VehicleData vehicleData;

  Ticket({
    required this.vehicleData,
    //required this.currentLocation,
    //required this.trackingLocation,
    required this.id,
    required this.customerUid,
    //this.mechanicUid,
    required this.scheduleOfService,
    //required this.typesOfServices,
    //required this.query,
    required this.status,
    required this.paymentMode,
    required this.paymentStatus,
    required this.isVerifiedOnTimeOtp,
    required this.isVerifiedscheduledArrivedOtp,
    required this.isVerifiedscheduledWorkshopOtp,
    required this.isVerifiedscheduledDeliveredOtp,
    required this.createdAt,
    required this.updatedAt,
    required this.onTimeOtp,
    required this.v,
    required this.customerId,
    required this.mechanicId,
  });


  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      vehicleData: VehicleData.fromJson(json["vehicleData"]),
      //currentLocation: Location.fromJson(json["currentLocation"]),
      //trackingLocation: Location.fromJson(json["trackingLocation"]),
      id: json["_id"],
      customerUid: json["customerUid"]?? '',
      //mechanicUid: json["mechanicUid"],
      scheduleOfService: json["scheduleOfService"],
      //typesOfServices: List<dynamic>.from(json["typesOfServices"].map((x) => x)),
      //query: List<dynamic>.from(json["query"].map((x) => x)),
      status: json["status"],
      paymentMode: json["paymentMode"],
      paymentStatus: json["paymentStatus"],
      isVerifiedOnTimeOtp: json["isVerifiedOnTimeOTP"],
      isVerifiedscheduledArrivedOtp: json["isVerifiedscheduledArrivedOTP"],
      isVerifiedscheduledWorkshopOtp: json["isVerifiedscheduledWorkshopOTP"],
      isVerifiedscheduledDeliveredOtp: json["isVerifiedscheduledDeliveredOTP"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      onTimeOtp: json["onTimeOTP"],
      v: json["__v"],
      customerId: CustomerId.fromJson(json["customerId"]),
      mechanicId: MechanicId.fromJson(json["mechanicId"]),
    );
  }

}

class Location {
  double? latitude;
  double? longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json["latitude"]?.toDouble() ?? 0,
      longitude: json["longitude"]?.toDouble() ?? 0,
    );
  }

}


class CustomerId {
  Location currentLocation;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? photo;

  CustomerId(
      {
        required this.currentLocation,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.photo});


  factory CustomerId.fromJson(Map<String, dynamic> json) {
    return CustomerId(
      currentLocation: Location.fromJson(json["currentLocation"]),
      sId: json["_id"] ?? '',
      firstName: json['firstName']?? '',
      lastName: json['lastName']??'',
      email: json["email"] ?? '',
      photo: json["photo"] ?? '',
      //currentLocation: List<dynamic>.from(json["currentLocation"].map((x) => x)),
    );
  }

}
/*

class TrackingLocation {
  double? latitude;
  double? longitude;

  TrackingLocation({this.latitude, this.longitude});

  TrackingLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] ?? '';
    longitude = json['longitude'] ?? '';
  }
}
*/


class MechanicId {
  GeneralDetails generalDetails;
  Location location;
  String id;
  String locationHash;

  MechanicId({
    required this.generalDetails,
    required this.location,
    required this.id,
    required this.locationHash,
  });

  factory MechanicId.fromJson(Map<String, dynamic> json) {
    return MechanicId(
      generalDetails: GeneralDetails.fromJson(json["generalDetails"]),
      location: Location.fromJson(json["location"]),
      id: json["_id"],
      locationHash: json["locationHash"],
    );
  }

}

class GeneralDetails {
  String fullName;
  String email;
  String phoneNo;
  String address;
  String pincode;

  GeneralDetails({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.pincode,
  });

  factory GeneralDetails.fromJson(Map<String, dynamic> json) {
    return GeneralDetails(
      fullName: json["fullName"] ?? '',
      email: json["email"] ?? '',
      phoneNo: json["phoneNo"] ?? '',
      address: json["address"] ?? '',
      pincode: json["pincode"] ?? '',
    );
  }

}

class VehicleData {
  String vehicleModel;
  String vehicleBrand;
  String vehicleFuel;
  String vehicleNo;

  VehicleData({
    required this.vehicleModel,
    required this.vehicleBrand,
    required this.vehicleFuel,
    required this.vehicleNo,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
    vehicleModel: json["vehicleModel"],
    vehicleBrand: json["vehicleBrand"],
    vehicleFuel: json["vehicleFuel"],
    vehicleNo: json["vehicleNo"],
  );
}
