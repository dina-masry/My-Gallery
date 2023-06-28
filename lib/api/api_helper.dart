import 'dart:io';

import 'package:api/api/api_response.dart';
import 'package:api/prefs/shared_pref_controller.dart';

mixin ApiHelper{
  ApiResponse get errorResponse => ApiResponse(success: false, message: 'Something goes wrong');

  Map<String ,String> get headers =>
      {HttpHeaders.acceptHeader :'application/json',
        HttpHeaders.authorizationHeader : SharedPreController().getValueFor<String>(key: Prefkeys.token.name)!,

      };


}