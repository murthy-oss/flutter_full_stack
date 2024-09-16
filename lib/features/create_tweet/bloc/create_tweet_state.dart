part of 'create_tweet_bloc.dart';

@immutable
sealed class CreateTweetState {}

final class CreateTweetInitial extends CreateTweetState {}

abstract class CreateTweetActionState extends CreateTweetState{}
class CreateTweetLoadingState extends CreateTweetActionState{}
class CreateTweetSucessState extends CreateTweetActionState{}
class CreateTweetErrorState extends CreateTweetActionState{}