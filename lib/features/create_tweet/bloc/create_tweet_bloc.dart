import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_full_stack/features/create_tweet/repos/create_tweet_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'create_tweet_event.dart';
part 'create_tweet_state.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetState> {
  CreateTweetBloc() : super(CreateTweetInitial()) {
    on<CreateTweetPostEvent>
    (createTweetPostEvent);
  }

  FutureOr<void> createTweetPostEvent(CreateTweetPostEvent event, Emitter<CreateTweetState> emit) async{
emit(CreateTweetLoadingState());
String currentUserId=FirebaseAuth.instance.currentUser?.uid??"";
final uuid=Uuid().v1();
bool sucess=await CreateTweetRepo.
postTweetRepo(
  uuid,
   currentUserId, 
   event.content, 
   DateTime.now()
   );
print("success:$sucess");
if(sucess){
  emit(CreateTweetSucessState());
}
else{
  emit(CreateTweetErrorState());
}
  }
}
