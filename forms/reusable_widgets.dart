import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_news/model/newsapimodel.dart';
import 'package:app_news/screens/detailshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

CircleAvatar logoWidget(String imageName) {
  return CircleAvatar(
    radius: 75,
    backgroundColor: Colors.white,
    child: Image.asset(
      imageName,
    ),
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 15, 14, 14),
    style: TextStyle(
        color: const Color.fromARGB(255, 168, 66, 66).withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: const Color.fromARGB(179, 48, 153, 156),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromARGB(255, 70, 37, 131).withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 150,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(66, 255, 255, 255);
            }
            return const Color.fromARGB(255, 48, 39, 39);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Color.fromARGB(221, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    ),
  );
}

Widget listItems(BuildContext context, Size size, NewsApiModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
    child: GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DetailNews(
            model: model,
          ),
        ),
      ),
      child: Container(
        height: 210,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          color: Colors.white,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          model.imageUrl != ""
              ? SizedBox(
                  height: 150,
                  width: 375,
                  child: Image.network(
                    model.imageUrl,
                    fit: BoxFit.fill,
                  ),
                )
              : const Text("Cant Load image"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 300,
                  child: Text(model.title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ))),
              IconButton(
                  onPressed: () async {
                    addArticleDetails(model.imageUrl, model.title,
                        model.content, model.description);
                  },
                  icon: const Icon(Icons.bookmark)),
            ],
          ),
        ]),
      ),
    ),
  );
}

Future addArticleDetails(String imageUrl, title, content, description) async {
  User? user = FirebaseAuth.instance.currentUser;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection("articles")
      .add({
    'image': imageUrl,
    'title': title,
    'content': content,
    'description': description,
  });
}

Future removeArticle(index) async {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('articles')
      .doc(index)
      .delete();
}

Widget typer(String text1, String text2) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.greenAccent, Colors.white12, Colors.purple]),
    ),
    child: DefaultTextStyle(
      style: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedTextKit(isRepeatingAnimation: true, animatedTexts: [
        TyperAnimatedText(text1,
            textStyle: const TextStyle(color: Colors.black),
            speed: const Duration(milliseconds: 100)),
        TyperAnimatedText(text2,
            textStyle: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
            speed: const Duration(milliseconds: 100)),
      ]),
    ),
  );
}
