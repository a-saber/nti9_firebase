import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nti9_firebase/core/utils/app_theme.dart';
import 'package:nti9_firebase/features/auth/presentation/views/login_view.dart';
import 'package:nti9_firebase/features/home/presentation/views/add_post_view.dart';
import 'package:nti9_firebase/features/home/presentation/views/my_posts_view.dart';
import 'package:nti9_firebase/features/home/presentation/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: AppColors.accent,
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('My Profile'),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileView(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('My Posts'),
              leading: Icon(Icons.post_add),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPostsView()),
                );
              },
            ),
            Spacer(),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (r) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get(),
          builder: (context, snapshot) {
            Map<String, dynamic>? userData;
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              userData = snapshot.data?.data();
            }
            return Text('Hello ${userData?['name'] ?? ''}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPostView()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('created_at', descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              var posts = snapshot.data?.docs ?? [];
              return ListView.separated(
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(posts[index]['user_id'])
                                .get(),
                            builder: (context, ownerSnapshot) {
                              if (ownerSnapshot.hasData &&
                                  ownerSnapshot.connectionState ==
                                      ConnectionState.done) {
                                return Text(
                                  ownerSnapshot.data?.data()?['name'] ?? '',
                                );
                              }
                              return SizedBox();
                            },
                          ),
                          subtitle: Text(
                            (posts[index]['created_at'] as Timestamp)
                                .toDate()
                                .toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileView(uid: posts[index]['user_id']),
                              ),
                            );
                          },
                        ),
                        Text(posts[index]['title']),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: posts.length,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error'));
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
