class Student{
  late int id ;
  late String fullName;
  late bool isActive;
  late String email;
  late String token;
  late String gender;
  late String refreshToken;
  late String? fcmToken;

  Student();

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    refreshToken = json['refresh_token'];
    isActive = json['is_active'];
  }
}
