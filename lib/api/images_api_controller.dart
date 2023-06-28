import 'dart:convert';
import 'dart:io';
import 'package:api/api/api_helper.dart';
import 'package:api/api/api_settings.dart';
import 'package:api/models/student-image.dart';
import 'package:api/prefs/shared_pref_controller.dart';
import 'package:http/http.dart'as http;
import 'api_response.dart';
class ImagesApiController with ApiHelper{

  Future<ApiResponse<StudentImage>> uploadImage (String path)async{
    Uri uri = Uri.parse(ApiSettings.image.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', uri);
    var imageFile = await http.MultipartFile.fromPath('image', path);
    request.files.add(imageFile);
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] = SharedPreController().getValueFor<String>(key: Prefkeys.token.name)!;
    var response = await request.send();
    var body = await response.stream.transform(utf8.decoder).first;
    var jsonResponse =  jsonDecode(body);
    if(response.statusCode == 201 || response.statusCode==400){
      var apiResponse =  ApiResponse<StudentImage>(success: jsonResponse['status'], message: jsonResponse['message']);
      if(response.statusCode ==201){
        StudentImage studentImage = StudentImage.fromJson(jsonResponse['object']);
        apiResponse.object = studentImage;
      }
      return apiResponse;
    }
    return ApiResponse(message: 'Something goes wrong!', success: false);

  }
  Future<List<StudentImage>> read() async{
    Uri uri = Uri.parse(ApiSettings.image.replaceFirst('/{id}', ''));
    var response = await http.get(uri , headers: headers);
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
       return jsonArray.map((jsonObject) => StudentImage.fromJson(jsonObject)).toList();
    }
    return [];

}
  Future<ApiResponse> delete (int id)async{
    Uri uri = Uri.parse(ApiSettings.image.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri , headers:  headers);
    if(response.statusCode==200){
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(success: jsonResponse['status'], message: jsonResponse['message']);
    }
    return errorResponse;

  }

}