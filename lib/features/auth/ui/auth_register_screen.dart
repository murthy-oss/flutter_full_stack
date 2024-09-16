import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_stack/design/app_widget.dart';
import 'package:flutter_full_stack/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_full_stack/features/tweet/ui/tweet_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final _formkey = Key('formkey');
  bool isLogin = true;
  AuthBloc _authBloc=AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: AppLogoWidget()
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listenWhen: (previous, current) => current is AuthActionState ,
        buildWhen: (previous, current) => current is !AuthActionState,
        listener: (context, state) {
          print("ghvgh$state");
          if(state is AuthErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: 
              Text(state.error))
            );
           
          }
          else if(state is AuthLoadingState){
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: 
              CircularProgressIndicator())
            );
          }
          else if(state is AuthSuccessState){
              
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: 
              Text("sucessfully login"))
            );
              Navigator.popUntil(context,
               (route) => route.isFirst);
              // Navigator.push(context, MaterialPageRoute(builder: 
              // (context)=>TweetsPage()));
            }
        },
        builder: (context, state) {
          return Form(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isLogin)
                    SizedBox(
                      height: 10,
                    ),
                  if (!isLogin) Text("Enter Name"),
                  if (!isLogin)
                    TextFormField(
                      controller: _namecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(hintText: 'Enter your Name'),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Enter email"),
                  TextFormField(
                    controller: _emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Enter email'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Enter password"),
                  TextFormField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          print("object");
                  _authBloc.add(AuthenticationEvent(
                    authType: isLogin ?AuthType.login:AuthType.Register, 
                    email: _emailcontroller.text, 
                    password: 
                    _passwordcontroller.text));
                        },
                        child: Text(isLogin ? "Login" : "Register")),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !isLogin
                            ? "Don't have an account?"
                            : "Already have an account?",
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          !isLogin ? "Login" : "Register",
                          style: TextStyle(color: Colors.deepPurple.shade200),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
