import 'package:dio/dio.dart';
import 'package:flutter_full_stack/core/config.dart';

class CreateTweetRepo{
  

  static Future<bool> postTweetRepo(String tweetId,adminId,content,DateTime createdAt) async{
   try{ Dio dio=Dio();
   final response= await dio.post(Config.serverUrl+'/tweet',data: 
   { 'tweetid':tweetId,
    'adminId':adminId,
    'content':content,
    'createdAt':createdAt.toIso8601String(),
    }

    );
    print(response);
    if(response.statusCode!>=200 && response.statusCode!<=300){
      return true;
    }
    else{
      return false;
    }
    
  }catch(e){
    print(e.toString());
    return false;
  }
  
  
  }
  
}