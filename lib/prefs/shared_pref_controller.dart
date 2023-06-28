import 'package:shared_preferences/shared_preferences.dart';

import '../models/Student.dart';
enum Prefkeys{
  loggedIn , id ,name , email, gender , token , isActive
}
class SharedPreController{
  SharedPreController._();
 late SharedPreferences _sharedPreferences;
  static SharedPreController? _instance;
  factory SharedPreController(){
    return _instance ??= SharedPreController._();
  }
  Future<void> initPref()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void save(Student student)async{
    await _sharedPreferences.setBool(Prefkeys.loggedIn.name, true);
    await _sharedPreferences.setInt(Prefkeys.id.name, student.id);
    await _sharedPreferences.setString(Prefkeys.name.name, student.fullName);
    await _sharedPreferences.setString(Prefkeys.email.name, student.email);
    await _sharedPreferences.setString(Prefkeys.gender.name, student.gender);
    await _sharedPreferences.setString(Prefkeys.token.name, 'Bearer ${student.token}');
    await _sharedPreferences.setBool(Prefkeys.isActive.name, student.isActive);

  }
  T? getValueFor<T>({required String key}){
   if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.get(key) as T;
   }
   return null;
  }
  Future<bool> clear() async => await _sharedPreferences.clear();

}