import 'package:app_news/forms/reusable_widgets.dart';
import 'package:app_news/screens/detailedsaved.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatefulWidget {
  const SavedItems({Key? key}) : super(key: key);

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  bool isLoading = true;

  List<String> docIDs = [];

  Future getDocID() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('articles')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              docIDs.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    CollectionReference article = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('articles');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
      ),
      body: FutureBuilder(
          future: getDocID(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: docIDs.length,
              itemBuilder: ((context, index) {
                return FutureBuilder<DocumentSnapshot>(
                    future: article.doc(docIDs[index]).get(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DetailedSaved(
                                  a: data['image'],
                                  b: data['title'],
                                  c: data['content'],
                                  d: data['description']),
                            ),
                          ),
                          child: Container(
                            height: 210,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 375,
                                  child: Image.network(
                                    data['image'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          width: 300,
                                          child: Text(data['title'],
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      IconButton(
                                          onPressed: () async {
                                            removeArticle(docIDs[index]);
                                          },
                                          icon: const Icon(Icons.remove)),
                                    ]),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Text('Not Loading');
                    }));
              }),
            );
          }),
    );
  }
}
