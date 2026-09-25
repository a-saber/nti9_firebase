import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPostsView extends StatelessWidget {
  const MyPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('posts')
            .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .orderBy('created_at', descending: true)
                .get(),
            builder: (context, snapshot){
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                var posts = snapshot.data?.docs ??[];
                return ListView.separated(
                    itemBuilder:  (context, index)=> Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users').doc(posts[index]['user_id']).get(),
                                  builder: (context, ownerSnapshot) {
                                    if(ownerSnapshot.hasData && ownerSnapshot.connectionState == ConnectionState.done) {
                                      return Text(ownerSnapshot.data?.data()?['name']??'');
                                    }
                                    return SizedBox();
                                  }
                              ),
                              subtitle: Text((posts[index]['created_at'] as Timestamp).toDate().toString(),
                                style: TextStyle(
                                    fontSize: 12
                                ),),
                              onTap: (){
                                // TODO: navigate to profile view
                              },
                            ),
                            Text(posts[index]['title']),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index)=> Divider(),
                    itemCount: posts.length
                );
              }
              else if(snapshot.hasError){
                return Center(child: Text('Error'));
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
