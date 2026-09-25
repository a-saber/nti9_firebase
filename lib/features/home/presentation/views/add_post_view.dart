import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nti9_firebase/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:nti9_firebase/features/auth/presentation/views/widgets/auth_text_field.dart';
import 'package:nti9_firebase/features/auth/presentation/views/widgets/primary_button.dart';
import 'package:nti9_firebase/features/auth/presentation/views/widgets/social_auth_row.dart';
import 'package:nti9_firebase/features/home/presentation/views/home_view.dart';

import '../../../../core/utils/app_theme.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await addTask();
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }
  addTask() async {
    try {
     
      await FirebaseFirestore.instance.collection('posts')
          .add({
        'title': _titleController.text,
        'created_at': DateTime.now(),
        'user_id': FirebaseAuth.instance.currentUser?.uid 
      });

    Fluttertoast.showToast(
          msg: "Post Submitted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.success,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }  catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Error happened\n try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.ink),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const AuthHeader(
                  title: 'Make new post',
                  subtitle: 'A few details and you\u2019re ready to go.',
                ),
                const SizedBox(height: AppSpacing.xxl),
                AuthTextField(
                  label: 'Title',
                  controller: _titleController,
                  prefixIcon: Icons.title,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter post title';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                PrimaryButton(
                  label: 'Submit',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}