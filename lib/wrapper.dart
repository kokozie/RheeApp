import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'handler.dart';
import 'model/firebaseuser.dart';

class Wrapper extends StatelessWidget{
  const Wrapper({super.key});


  @override
  Widget build(BuildContext context) {

    final user =  Provider.of<FirebaseUser?>(context);

    if(user == null)
    {
      return const Handler();
    }else
    {
      return const Home();
    }

  }
}