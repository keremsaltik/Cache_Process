//Data models is here. Data(s) will save json format
class MailPasswordModel {
  String? mail;
  String? password;

  MailPasswordModel({this.mail, this.password});

  MailPasswordModel.fromJson(Map<String, dynamic> json) {
    mail = json['mail'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail'] = mail;
    data['password'] = password;
    return data;
  }
}
