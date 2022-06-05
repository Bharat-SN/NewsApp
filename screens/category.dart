import 'package:app_news/forms/navdrawer.dart';
import 'package:app_news/screens/categories/business.dart';
import 'package:app_news/screens/categories/entertainment.dart';
import 'package:app_news/screens/categories/health.dart';
import 'package:app_news/screens/categories/science.dart';
import 'package:app_news/screens/categories/sports.dart';
import 'package:app_news/screens/categories/technology.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({Key? key}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      drawer: const NavDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back4.gif'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/entertainment.png',
                    height: 120,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const Entertainment()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/sports.png',
                    height: 120,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Sports()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/technology.png',
                    height: 120,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Technology()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/health.png',
                    height: 120,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Health()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/science.png',
                    height: 120,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Science()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/business.png',
                    height: 120,
                    width: 150,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Business()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
