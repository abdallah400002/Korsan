import 'dart:ui';
import 'package:chess/Pieces.dart';
import 'package:chess/gameMannager.dart';
import 'package:chess/game_picker_overlay.dart';
import 'package:chess/inGame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';


class GameType {
  Duration duration;
  String time;
  String name;

  GameType(this.duration, this.time, this.name);
}

  OverlayEntry? overlayEntry;
  late Overlay overlay;
  late AnimationController animationController;
  late Animation anim;
late Size deviceSize;
gameMannager gm = gameMannager();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  int whiteTime = 180;
  int blackTime = 180;
  Color white = const Color(0xFFd32ee6);
  Color black = const Color(0xFF2351fc);
  bool light =true;

  void showOverlay() {
    animationController.forward();
    overlayEntry = OverlayEntry(builder: (context) {
      return GamePickerOverlay();
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    });
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  bool overlayOn = false;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    anim = Tween(begin: 0.0001, end: 5.0).animate(animationController);
    animationController.addListener(() {
      if (animationController.isDismissed) {
        overlayEntry?.remove();
        overlayEntry = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: ()async{
        if(overlayOn){
          animationController.reverse();
          return false;
        }
        return true;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            color: const Color(0xFF13151D),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF2D313E), Color(0xFF13151D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.3],
                    tileMode: TileMode.clamp)),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.05,
            ),
            child: Column(
              children: [
                SizedBox(height: deviceSize.height*0.02,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Welocme,",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF9799a0))),
                        Text("what would you like to do?",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF535772))),
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: 50,
                      height: 50.0,
                      child: Image.asset(
                        "images/avatar1.jpg",
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  height: deviceSize.height*0.35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        startAngle: 28,
                        radius: 110.0,
                        lineWidth: 23.0,
                        animation: true,
                        percent: 0.92,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color(0xFF4b69ff),
                        backgroundColor: const Color(0xFF2f3341),
                      ),
                      CircularPercentIndicator(
                        startAngle: 28,
                        radius: 110,
                        lineWidth: 23.0,
                        animation: true,
                        percent: 0.41,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text("120",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:deviceSize.width*0.12,
                                    color: Colors.white)),
                            Text("games",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:deviceSize.width*0.04,
                                    color: Color(0xFF535772))),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: const Color(0xFFfd7343),
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Expanded(child: Container()),
                     Icon(
                      Icons.circle,
                      color: Color(0xFF4b69ff),
                      size: deviceSize.height*0.015,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text("54%",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: deviceSize.height*0.02,
                                color: Colors.white)),
                        Text("Victories",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: deviceSize.height*0.02,
                                color: Color(0xFF535772))),
                      ],
                    ),
                    Expanded(child: Container(),flex: 3,),

                     Icon(
                      Icons.circle,
                      color: Color(0xFFfd7343),
                      size: deviceSize.height*0.015,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text("41%",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: deviceSize.height*0.02,
                                color: Colors.white)),
                        Text("Defeats",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: deviceSize.height*0.02,
                                color: Color(0xFF535772))),
                      ],
                    ),
                    Expanded(child: Container(),flex: 3,),
                     Icon(
                      Icons.circle,
                      color: Color(0xFF2f3341),
                      size: deviceSize.height*0.015,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("5%",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: deviceSize.height*0.02,
                                color: Colors.white)),
                        Text("Draws",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: deviceSize.height*0.02,
                                color: Color(0xFF535772))),
                      ],
                    ),
                    Expanded(child: Container()),

                  ],
                ),
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: (deviceSize.height*0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2D313E),
                                        Color(0xFF13151D)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: [0, 0.6],
                                      tileMode: TileMode.clamp)),
                              child: Image.asset(
                                "images/Frame_1.png",
                                color: white.withOpacity(.7),
                                scale: 8,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: (deviceSize.height*0.2),
                              height: (deviceSize.height*0.2),
                              child: const Text("Play",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Color(0xFF535772))),
                            ),
                            Container(
                              width: (deviceSize.height*0.2),
                              height: (deviceSize.height*0.2),
                              child: GestureDetector(
                                onTap: () {
                                  overlayOn = true;
                                  showOverlay();
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.width * .05,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: (deviceSize.height*0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2D313E),
                                        Color(0xFF13151D)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: [0, 0.6],
                                      tileMode: TileMode.clamp)),
                              child: Image.asset(
                                "images/darts.png",
                                color: black,
                                scale: 8,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: (deviceSize.height*0.2),
                              height: (deviceSize.height*0.2),
                              child: const Text("Study",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Color(0xFF535772))),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: (deviceSize.height*0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2D313E),
                                        Color(0xFF13151D)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: [0, 0.6],
                                      tileMode: TileMode.clamp)),
                              child: Image.asset(
                                "images/puzzle.png",
                                color: black,
                                scale: 8,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: (deviceSize.height*0.2),
                              height: (deviceSize.height*0.2),
                              child: const Text("Puzzles",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Color(0xFF535772))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.width * .05,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: (deviceSize.height*0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF2D313E),
                                        Color(0xFF13151D)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: [0, 0.6],
                                      tileMode: TileMode.clamp)),
                              child: Image.asset(
                                "images/view.png",
                                color: const Color(0xFF543498),
                                scale: 8,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: (deviceSize.height*0.2),
                              height: (deviceSize.height*0.2),
                              child: const Text("Watch",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Color(0xFF535772))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
               AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaY: anim.value, sigmaX: anim.value),
                        child: Container(
                        ),
                      ))
        ],
      )
      ),
    );
  }
}
