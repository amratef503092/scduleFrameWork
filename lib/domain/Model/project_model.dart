class ProjectModel{
  var dead_line;
  String ?descriptions;
  String ?title;
  String  ? link;
  var time_upload;
  var   upload;
  String ?status;


  ProjectModel.fromJson(Map<String, dynamic> json){
    dead_line = json['dead line'];
    descriptions = json['descriptions'];
    title = json['title'];
    time_upload = json['time upload'];
    link = json['file'];
    status = json['status'];

  }

  Map<String, dynamic> toMap() {

    return {
      'dead line' : dead_line,
      'descriptions' : descriptions,
      'title' :title ,
      'time upload' : time_upload,
    };



  }

}