import 'package:dio/dio.dart';
import 'package:flutter_full_stack/core/config.dart';
import 'package:flutter_full_stack/features/tweet/model/tweet_model.dart';

class TweetRepo{
 static Future<List<TweetModel>> getAllTweets() async{
  try { 
    
    Dio dio=Dio();
    print("comming");
    final response=await dio.get(Config.serverUrl+'/tweet/get/all');
    
    List<TweetModel>tweets=[];
    
    if(response.statusCode==200){

for(int i=0;i<response.data['data'].length;i++){
  tweets.add(
    TweetModel.fromMap(
    response.data['data'][i]['tweet']
  ));

}
print("ettu${response.data['data'][0]}");
    }
    else{
      print("Request failed with status: ${response.statusCode}");
      return [];
    }
    return tweets;
  }
  catch(e){
    print(e.toString());
    return [];
  }
  
  }
}