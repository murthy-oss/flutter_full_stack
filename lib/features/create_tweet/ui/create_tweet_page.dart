import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_stack/features/create_tweet/bloc/create_tweet_bloc.dart';
import 'package:flutter_full_stack/features/tweet/ui/tweet_page.dart';

class CreateTweetPage extends StatefulWidget {
  const CreateTweetPage({super.key});

  @override
  State<CreateTweetPage> createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  CreateTweetBloc createTweetBloc = CreateTweetBloc();
  TextEditingController _ContentController = TextEditingController();
  bool loader=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateTweetBloc, CreateTweetState>(
        bloc: createTweetBloc,
        listenWhen: (previous, current) => current is CreateTweetActionState,
        buildWhen: (previous, current) => current is !CreateTweetActionState,
        listener: (context, state) {
         
if(state is CreateTweetLoadingState)
{
  setState(() {
    loader=true;
  });
}
else if(state is CreateTweetSucessState){
  setState(() {
    loader=false;
  });
  Navigator.push(context, MaterialPageRoute(builder: (context)=>TweetsPage()));

}
else if(state is CreateTweetErrorState){
  setState(() {
    loader=false;
  });
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("something went wrong"))
  );
}

        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create Tweet",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: _ContentController,
                  maxLength: 100, 
                  minLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write Whats in your mind",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 48,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {

                        createTweetBloc.add(CreateTweetPostEvent(_ContentController.text));
                      },
                      child: loader?CircularProgressIndicator():
                      const Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
