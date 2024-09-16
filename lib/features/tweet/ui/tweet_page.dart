import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_stack/design/app_widget.dart';
import 'package:flutter_full_stack/features/create_tweet/ui/create_tweet_page.dart';
import 'package:flutter_full_stack/features/tweet/bloc/tweet_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  State<TweetsPage> createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  TweetBloc tweetBloc=TweetBloc();
  @override
  void initState() {
    // TODO: implement initState
    tweetBloc.add(TweetInitialFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTweetPage()));
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<TweetBloc, TweetState>(
        bloc: tweetBloc,
        
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print('fyugyjgyj${state.runtimeType}');
         switch(state.runtimeType){
          case TweetsSucessState:
            final successState=state as TweetsSucessState;
            print('kjndskjnhcd${successState.tweets[0].tweetid}');
             return Container(
            child: Column(
              children: [
                Center(child: AppLogoWidget()),
              Expanded(
                child: ListView.builder(
                  itemCount: successState.tweets.length,
                  itemBuilder: (context,index){
                    final tweet = successState.tweets[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Text(tweet.adminId[0].toUpperCase()),
                        ),
                        Text(tweet.content,
                        style: TextStyle(
                          color: Colors.white
                        ),
                        ),
                      ],
                    );
                  }
                ),
              )
              ],
            ),
          );
          case TweetsLoadState:
          return Center(
            child: CircularProgressIndicator(),
          );
          default:
          return SizedBox();
         }
        },
      ),
    );
  }
}
//  return Container(
//             child: Column(
//               children: [Center(child: AppLogoWidget())],
//             ),
//           );