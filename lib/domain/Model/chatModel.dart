
class ChatUserModel {

  late final String username;



  ChatUserModel.fromJson(Map<String, dynamic> json){
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;

    return _data;
  }
}