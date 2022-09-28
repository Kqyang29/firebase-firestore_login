class UserModel{
  String? uid;
  String? email;
  String? FirstName;
  String? LastName;

  UserModel({this.uid,this.email,this.FirstName,this.LastName});

  // receiving data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      FirstName: map['FirstName'],
      LastName: map['LastName']
    );
  }

  // send data to server
  Map<String,dynamic> toMap(){
    return{
      "uid": uid,
      "email": email,
      "FirstName":FirstName,
      "LastName": LastName
    };
  }
}