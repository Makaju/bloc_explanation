import 'package:bloc_explanation/cubits/internet_cubit.dart';
import 'package:bloc_explanation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_explanation/screens/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Explanation'),
      ),
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.Gained) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Connected to internet!!'),
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.all(10),
                ));
              } else if (state == InternetState.Lost) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar (
                  content: Text('Not connected to internet!!'),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(10),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Loading.....'),
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.all(10),
                ));
              }
            },
            builder: (context, state) {
              return ElevatedButton(child: const Text('Press Here'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider(
                                create: (context) => SignInBloc(),
                                child: LoginPage(),
                              )));
                },);
            },
          ),
        ),
      ),
    );
  }
}
