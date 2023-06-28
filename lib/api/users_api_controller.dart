import 'dart:convert';
import 'package:api/api/api_settings.dart';
import 'package:api/models/users.dart';
import 'package:http/http.dart'as http;

class UsersApiController{

Future<List<User>> getUsers()async{
  Uri uri = Uri.parse(ApiSettings.users);
  var response = await http.get(uri);
  if(response.statusCode ==200){
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'] as List;
    return data.map((jsonObject) => User.fromJson(jsonObject)).toList();
  }
  return [];
}
}