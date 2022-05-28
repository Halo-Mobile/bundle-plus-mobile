class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  bool? isVerified;

  UserModel(
      {this.uid, this.email, this.firstName, this.secondName, this.isVerified});

  // get data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
