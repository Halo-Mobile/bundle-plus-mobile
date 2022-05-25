class UserProfile {
  String? uid;
  String? phoneNum;

  UserProfile({this.uid, this.phoneNum});

  // get data from server
  factory UserProfile.fromMap(map) {
    return UserProfile(
      uid: map['uid'],
      phoneNum: map['phoneNum'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNum': phoneNum,
    };
  }
}