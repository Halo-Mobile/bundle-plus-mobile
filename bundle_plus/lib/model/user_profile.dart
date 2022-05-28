import 'dart:ffi';

class UserProfile {
  String? upid;
  String? phoneNum;
  String? matricCard;
  int? profilePic;

  UserProfile({this.upid, this.phoneNum, this.matricCard, this.profilePic});

  // get data from server
  factory UserProfile.fromMap(map) {
    return UserProfile(
      upid: map['upid'],
      phoneNum: map['phoneNum'],
      matricCard: map['matricCard'],
      profilePic: map['profilePic'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'upid': upid,
      'phoneNum': phoneNum,
      'matricCard': matricCard,
      'profilePic': profilePic,
    };
  }
}