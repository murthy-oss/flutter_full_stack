import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_full_stack/core/config.dart';
import 'package:flutter_full_stack/features/auth/models/user_model.dart';

class AuthRepo{
  static Future<UserModel?>getUserRepo(String uid)async{
try{

   Dio dio=Dio();
   final response= await dio.get(Config.serverUrl+"/user/$uid");
   print("response.statusCode${response.statusCode}");
   if(response.statusCode!>=200 && response.statusCode!<=300){
    print('response :${response.data['data']}');
    UserModel userModel=UserModel.fromMap(response.data['data']);
   // print('response :${userModel.uid}');
    return userModel;
   }
   else{
    return null;
   }
   
}catch(e){
  print(e.toString());
  return null;
}
    
  }
  static Future<bool> createUserRepo(UserModel userModel)async{
    Dio dio=Dio();
    final response=await dio.post(Config.serverUrl+"user",data: userModel.toMap());
    if(response.statusCode!>=200 && response.statusCode!<=300){
      return true;
    }
    else{
      return false;
    }
  }
}