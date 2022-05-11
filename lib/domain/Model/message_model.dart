class MessageModel {
 String ? senderId;
 String ? receiverId;
 String ? text;
 dynamic  dateTime;

 MessageModel({
    required this.senderId,
   required this.receiverId,
   required this.text,
   required this.dateTime
  });




 MessageModel.fromJson(Map<String, dynamic> json){
   senderId = json['sender'];
   receiverId = json['receiverId'];
   text = json['text'];
   dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {

   return {
     'sender' : senderId,
     'text' : text,
     'time' :dateTime ,
     'receiverId' : receiverId,
   };



  }
}