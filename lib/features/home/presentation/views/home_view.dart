import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // @override
  // void initState() {
  //   getUserData();
  //   super.initState();
  // }
  //
  // Map<String, dynamic>? userData;
  // getUserData () async {
  //   try {
  //     var result = await FirebaseFirestore.instance
  //         .collection('users').doc(FirebaseAuth.instance.currentUser?.uid)
  //         .get();
  //     setState(() {
  //       userData = result.data();
  //     });
  //
  //   }
  //       catch(e){
  //     print(e.toString());
  //       }
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users').doc(FirebaseAuth.instance.currentUser?.uid)
              .get(),
          builder: (context, snapshot){
            Map<String, dynamic>?  userData;
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
              userData = snapshot.data?.data();
            }
            return Text('Hello ${userData?['name']??''}');
          }
      ),
    );
  }
}
