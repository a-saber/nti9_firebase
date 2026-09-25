import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../auth/presentation/views/widgets/primary_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var userData = snapshot.data?.data();
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(radius: 60, child: Icon(Icons.person)),
                  ),
                  SizedBox(height: 20),
                  Text(userData?['name'] ?? ''),
                  SizedBox(height: 12),
                  Text(userData?['phone'] ?? ''),
                  SizedBox(height: 12),
                  Text(userData?['email'] ?? ''),
                  SizedBox(height: 20),
                  uid == FirebaseAuth.instance.currentUser?.uid ?
                  PrimaryButton(
                    label: 'Edit Profile',
                    isLoading: false,
                    onPressed: () {},
                  )
                  :
                  PrimaryButton(
                    label: 'Send Message',
                    isLoading: false,
                    onPressed: () {},
                  )
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }
          return SizedBox();
        },
      ),
    );
  }
}
