import 'package:app_news/forms/reusable_widgets.dart';
import 'package:app_news/model/user_model.dart';
import 'package:app_news/screens/about_us.dart';
import 'package:app_news/screens/category.dart';
import 'package:app_news/screens/home_screen.dart';
import 'package:app_news/screens/login.dart';
import 'package:app_news/screens/savedItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  static UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back2.gif'),
                fit: BoxFit.fill,
              ),
            ),
            accountName: const Text(
              "Daily Bugle News App",
              style: TextStyle(
                color: Colors.black,
                backgroundColor: Colors.yellow,
              ),
            ),
            accountEmail: Text("Logged in as ${loggedInUser.email}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white,
                )),
            currentAccountPicture: logoWidget('assets/images/BlackSpidey.png'),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back1.gif'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 65,
                ),
                ActionChip(
                  label: const Text('Home'),
                  avatar: const Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.amberAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const HomeScreen()));
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                ActionChip(
                  label: const Text('Categories'),
                  avatar: const Icon(Icons.category),
                  backgroundColor: Colors.lightBlueAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CategoryNews()));
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                ActionChip(
                  label: const Text('Saved'),
                  avatar: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SavedItems()),
                    );
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                ActionChip(
                  label: const Text('About Us'),
                  avatar: const Icon(
                    Icons.person,
                    color: Colors.pink,
                  ),
                  backgroundColor: Colors.greenAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const AboutUs()),
                    );
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                ActionChip(
                    avatar: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    onPressed: () {
                      logout(context);
                    }),
                const SizedBox(
                  height: 130,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
