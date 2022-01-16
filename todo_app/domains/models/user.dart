class User{
  String? email;
  String? name;
  String? photo;

  User({this.name, this.email, this.photo});

  @override
  String toString() {
    // TODO: implement toString
    return 'EMAIL $email, NAME $name, PHOTO $photo';
  }

  factory User.fromJSON(dynamic json){
    return User(name: json["name"], email: json["email"], photo: json["picture"]["data"]["url"]);
  }
}