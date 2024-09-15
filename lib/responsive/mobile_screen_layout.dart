import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
         AuthMethods().signOutUser();
      }, child: Text("Sign out"))
    );
  }
}
