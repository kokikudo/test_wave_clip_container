import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:good_appbar/utils/space_direction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Good Appbar',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xffFCF6FF),
      ),
      home: const GameListScreen(),
    );
  }
}

const List<String> gameImageURL = [
  'images/apex.jpg',
  'images/dbd.jpeg',
  'images/forttite.jpeg',
];

class GameListScreen extends StatelessWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Game List'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: gameImageURL.map((url) => GameTile(url: url)).toList(),
        ),
      ),
    );
  }
}

class GameTile extends StatelessWidget {
  const GameTile({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NewGamePageScreen()),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(url)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class NewGamePageScreen extends StatelessWidget {
  const NewGamePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 背景。ぼかした画像の下にExpandedなSizedoxを設置。
          Column(
            children: [
              Stack(
                children: [
                  TopGameImage(),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
            ],
          ),

          // 上から50下がったとこからメインコンテンツを配置したい。
          Positioned(
            top: 50,
            child: ClipPath(
              clipper: TopWaveClipper(),

              // Containerの配置には成功。
              child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: size.width,
                  height: size.height,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
                child: Contents(),
              ),),
            ),
          ),
        ],
      ),
    );
  }
}

class Contents extends StatelessWidget {
  const Contents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage("images/apex.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Icon(Icons.favorite_border),
          ],
        ),
        addVerticalSpace(20),
        Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
        Text('inc name', style: TextStyle(fontSize: 20, color: Colors.grey),),
      ],
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.lineTo(0, size.height * 0.1110623);
    path_0.quadraticBezierTo(size.width * 0.1682547, size.height * 0.0392508,
        size.width * 0.2675741, size.height * 0.0399971);
    path_0.cubicTo(
        size.width * 0.3627613,
        size.height * 0.0288850,
        size.width * 0.4385756,
        size.height * 0.1748317,
        size.width * 0.5140253,
        size.height * 0.1355634);
    path_0.cubicTo(
        size.width * 0.5852212,
        size.height * 0.1564852,
        size.width * 0.7069519,
        size.height * 0.1363418,
        size.width * 0.7768109,
        size.height * 0.1260931);
    path_0.quadraticBezierTo(size.width * 0.8535732, size.height * 0.1260931,
        size.width, size.height * 0.1760755);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class TopGameImage extends StatelessWidget {
  const TopGameImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: window.physicalSize.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/apex.jpg'), fit: BoxFit.fill),
      ),
    );
  }
}
