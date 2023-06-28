import 'dart:convert';
import 'dart:io';
import 'package:api/api/api_helper.dart';
import 'package:api/api/api_response.dart';
import 'package:api/api/api_settings.dart';
import 'package:api/models/Student.dart';
import 'package:api/prefs/shared_pref_controller.dart';
import 'package:http/http.dart'as http;
class AuthApiController with ApiHelper{

  Future<ApiResponse> login({required String email , required String password})async {
    Uri uri = Uri.parse(ApiSettings.login);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Student student = Student.fromJson(jsonResponse['object']);
         SharedPreController().save(student);
      }
      return ApiResponse(
          success: jsonResponse['status'], message: jsonResponse['message']);
    }
    return errorResponse;
  }

  Future<ApiResponse> register({ required String fullName,required String email , required String password ,
  required String gender})async {
    Uri uri = Uri.parse(ApiSettings.register);
    var response = await http.post(uri, body: {
      'full_name':fullName,
      'email': email,
      'password': password ,
      'gender' :gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          success: jsonResponse['status'], message: jsonResponse['message']);
    }
    return errorResponse;
  }
  Future<ApiResponse> logout()async{
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri , headers: {
      HttpHeaders.acceptHeader :'application/json',
      HttpHeaders.authorizationHeader : SharedPreController().getValueFor<String>(key: Prefkeys.token.name)!
    });
    if (response.statusCode == 200 || response.statusCode == 401) {
       SharedPreController().clear();
      return ApiResponse(
          success: true, message: 'Logged out successfully');
    }
    return errorResponse;
  }


  }
