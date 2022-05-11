class UserModel{
  String username;
  String text;
  String date;
  UserModel({required this.username , required this.text ,required this.date });
  static UserModel fromJson(Map<String,dynamic> json)=>UserModel(
    username : json['username'],
    text: json['text'],
    date: json['time'],
  );
}