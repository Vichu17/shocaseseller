class UserModel {
  String? user_id;
  String? user_name;
  String? user_email;
  String? user_mobile;
  String? avatar_url;
  UserModel({this.user_id, this.user_name, this.user_email, this.user_mobile, this.avatar_url});
  UserModel.fromData(Map<String, dynamic> data)
      : user_id = data['user_id'],
        user_name = data['user_name'],
        user_email = data['user_email'],
        user_mobile = data['user_mobile'],
        avatar_url = data['avatar_url'];

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name,
      'user_email': user_email,
      'user_mobile': user_mobile,
      'avatar_url' : avatar_url,
    };
  }
}