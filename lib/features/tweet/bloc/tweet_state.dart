part of 'tweet_bloc.dart';

@immutable
sealed class TweetState {}

final class TweetInitial extends TweetState {}

class TweetsLoadState extends TweetState{}

class TweetsSucessState extends TweetState{
  final List<TweetModel>tweets;

  TweetsSucessState({required this.tweets});

  
}

class TweetsErrorState extends TweetState{}