import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_stack/core/local_db/shared_prefs_manager.dart';
import 'package:flutter_full_stack/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter_full_stack/features/tweet/ui/tweet_page.dart';

class DecidePage extends StatefulWidget {
  const DecidePage({super.key});


static StreamController<String> authStream=StreamController.broadcast();

  @override
  State<DecidePage> createState() => _DecidePageState();
}



class _DecidePageState extends State<DecidePage> {
  @override
  void initState() {
    // TODO: implement initState
getUid();
    super.initState();
  }
getUid()async{
  String uid=await SharedPreferencesmanager.getUid();
  print("uid11$uid");
  if(uid.isEmpty)
  DecidePage.authStream.add("");
  else
  DecidePage.authStream.add(uid);
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream:DecidePage.authStream.stream, 
      builder: (context,snapshot){
        if(snapshot.data==null || (snapshot.data?.isEmpty??true)){
          return OnboardingScreen();
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else{
          return TweetsPage();

        }
      });
  }
}