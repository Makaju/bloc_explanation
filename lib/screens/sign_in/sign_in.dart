import 'package:bloc_explanation/screens/sign_in/bloc/sign_in_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Login with email'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.redAccent),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: emailController,
                onChanged: (value) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangeEvent(
                          emailController.text, passwordController.text));
                },
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: passwordController,
                onChanged: (value) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangeEvent(
                          emailController.text, passwordController.text));
                },
                decoration: const InputDecoration(hintText: 'Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if (state is SignInLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return CupertinoButton(
                      color: (state is SignInErrorState)
                          ? Colors.grey
                          : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10.0),
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      onPressed: state is SignInErrorState
                          ? null
                          : () {
                        print('State changed ' + state.toString());
                              if (state is SignInValidState) {

                                BlocProvider.of<SignInBloc>(context).add(
                                    SignInSubmittedEvent(emailController.text,
                                        passwordController.text));
                              }
                            },
                      child: const Text('Sign in'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
