import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            "assets/ic_instagram.svg",
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.messenger))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return snapshot.data!.docs.length == 0
                  ? Center(
                      child: Text("No Data available"),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => PostCard(
                            snap: snapshot.data!.docs[index],
                          ));
            }));
  }
}
