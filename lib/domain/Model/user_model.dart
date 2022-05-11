class UserModel{
  String username;
  String password;
  UserModel({required this.username , required this.password});
  static UserModel fromJson(Map<String,dynamic> json)=>UserModel(
      username : json['username'],
      password: json['password'],
  );

}