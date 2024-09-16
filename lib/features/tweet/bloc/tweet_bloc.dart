import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_full_stack/features/tweet/model/tweet_model.dart';
import 'package:flutter_full_stack/features/tweet/repos/tweet_repo.dart';
import 'package:meta/meta.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  TweetBloc() : super( TweetInitial()) {
    on<TweetInitialFetchEvent>(tweetInitialFetchEvent);
  }

  FutureOr<void> tweetInitialFetchEvent(TweetInitialFetchEvent event, Emitter<TweetState> emit) async{
    emit(TweetsLoadState());
    List<TweetModel>tweets=await TweetRepo.getAllTweets();
    print('eekkada$tweets');
    emit(TweetsSucessState(tweets: tweets));
  }
}
