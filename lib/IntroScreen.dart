import 'dart:ui';
import 'introscreen.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';
import 'pages/Quran.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xfff8bd58), Color(0xfffaf7bb)],
                radius: 0.9,
//              focalRadius: 10.0
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Container(
                          child: Text("আল কোরআন",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
                        child: Text(
                            "পড় তোমার প্রভুর নামে, যিনি তোমাকে সৃষ্টি করেছেন (সূরা আলাক : ১)",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: AvatarGlow(
                        endRadius: 200,
                        duration: Duration(seconds: 2),
                        repeatPauseDuration: Duration(seconds: 1),
                        startDelay: Duration(seconds: 1),
                        glowColor: Color(0xfffafafa),
                        repeat: true,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.none,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 8.0),
                              child: CircleAvatar(
                                backgroundColor: Color(0xff06070a),
                                child: ClipOval(
                                  child: Image.asset("assets/images/logo.png",
                                      //color: Colors.transparent,
                                      fit: BoxFit.cover,
                                      width: 160.0,
                                      height: 160.0),
                                ),
                                radius: 80.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      child: Center(
                        child: Text("© Created by Rezuwan",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuranPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff8bd58),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Center(
                            child: Text("সূরাসমূহ দেখুন",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
