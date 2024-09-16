import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_full_stack/core/local_db/shared_prefs_manager.dart';
import 'package:flutter_full_stack/features/app.dart';
import 'package:flutter_full_stack/features/auth/models/user_model.dart';
import 'package:flutter_full_stack/features/auth/repos/auth_repo.dart';
import 'package:flutter_full_stack/features/auth/ui/auth_register_screen.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthType{login,Register}
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
   on<AuthenticationEvent>(authenticationEvent);
  }

  FutureOr<void> authenticationEvent(AuthenticationEvent event, Emitter<AuthState> emit) async{

    UserCredential?  credential;
switch (event.authType) {
  case AuthType.login:
    try {
   credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: event.email,
    password: event.password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.' );
     emit(AuthErrorState(error: "No user found for that email."));
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.' );
     emit(AuthErrorState(error: "Wrong password provided for that user."));
  }
}
    break;

  case AuthType.Register:
  try {
   credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: event.email,
    password: event.password,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.' );
    emit(AuthErrorState(error: "The password provided is too weak."));
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.' );
    emit(AuthErrorState(error: "The account already exists for that email."));
  }
} catch (e) {
  print(e);
    emit(AuthErrorState(error: "Something went wrong"));

}
 
}

if(credential!=null){
 print('credential user${credential.user?.uid}');
  if(event.authType==AuthType.login)
  {
    print('credential:${credential.user?.uid}');
   UserModel? userModel=await AuthRepo.getUserRepo(credential.user?.uid??"");
   print(userModel?.uid);
   if(userModel!=null){
    print('credential:${credential.user?.uid}');
     
    await SharedPreferencesmanager.saveUid(credential.user?.uid??"");
    String name=SharedPreferencesmanager.getUid();
    print("name:$name");

    DecidePage.authStream.add(credential.user?.uid??"");
    
    emit(AuthSuccessState());
   }
   else{
    emit(AuthErrorState(error: "Something went wrong"));
   }
  }
  else if(event.authType==AuthType.Register){
   bool sucess= await AuthRepo.createUserRepo(
      UserModel(uid: credential.user?.uid??"",
       tweets: [], 
       firstName: "vinay", 
       lastName: "Lakkoju", 
       email: event.email, 
       createdAt: DateTime.now()));
       if(sucess){
        print(sucess);
       await SharedPreferencesmanager.saveUid(credential.user?.uid??"");
         DecidePage.authStream.add(credential.user?.uid??"");
        emit(AuthSuccessState());
       }
       else{
        emit(AuthErrorState(error: "Something went wrong"));
       }
  }
  else{
    print("credential is null");
        emit(AuthErrorState(error: "Something went wrong"));
    
  }
}

  }
}
