class UserModel{
  String? firstName;
  String? secondName;
  String? email;
  String? avatar;
  String? fullName;



  UserModel({
    this.firstName,
    this.secondName,
    this.email,
    this.avatar,
    this.fullName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    secondName = json['secondName'];
    email = json['email'];
    avatar = json['avatar'];
    fullName = json['fullName'];
  }
  Map<String,dynamic> toJson(){
    return {
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'avatar': avatar,
      'fullName': fullName,
    };
  }
}