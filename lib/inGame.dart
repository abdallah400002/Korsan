import 'dart:async';
import 'dart:ui';
import 'package:chess/Home.dart';
import 'package:chess/Pieces.dart';
import 'package:chess/gameMannager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class inGame extends StatefulWidget {
  GameType gameType;
  inGame(this.gameType, {Key? key}) : super(key: key);

  @override
  State<inGame> createState() => inGameState();
}

class inGameState extends State<inGame> with TickerProviderStateMixin {
  late Duration whiteTime;
  late Duration blackTime;
  Color cringeWhite = const Color(0xFFd32ee6);
  Color cringeBlack = const Color(0xFF2351fc);
  late AnimationController animationController;
  late Animation anim;
  bool WonOnTime = false;
  bool DrawnOnTime = false;

  void timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (whiteTime.inSeconds > 0 && gm.turns) {
        setState(() {
          whiteTime -= const Duration(seconds: 1);
        });
      } else if (blackTime.inSeconds > 0 && !gm.turns) {
        setState(() {
          blackTime -= const Duration(seconds: 1);
        });
      } else if (whiteTime.inSeconds == 0) {
        if (gm.b <= 2 && gm.empty) {
          DrawnOnTime = true;
          drawOverlay();
        } else {
          WonOnTime = true;
          checkmateOverlay();
        }
        timer.cancel();
      } else if (blackTime.inSeconds == 0) {
        if (gm.w <= 2 && gm.empty) {
          DrawnOnTime = true;
          drawOverlay();
        } else {
          WonOnTime = true;
          checkmateOverlay();
        }
        timer.cancel();
      }
    });
  }

  late Size deviceSize;
  late Overlay overlay;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    whiteTime = widget.gameType.duration;
    blackTime = widget.gameType.duration;
    super.initState();
    gm.init();
    timer();

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

  void promotionOverlay() {
    animationController.forward();
    overlayEntry = OverlayEntry(builder: (context) {
      return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                width: deviceSize.width * .7,
                height: deviceSize.height * .1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF13151D),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      SizedBox(
                        width: (deviceSize.width * .6) / 4 * 0.65,
                        child: GestureDetector(
                          child: Image.asset(
                            gm.cringeMode
                                ? "images/cringeQ.png"
                                : "images/q.png",
                            color: !gm.turns
                                ? (gm.cringeMode ? cringeWhite : Colors.white)
                                : (gm.cringeMode ? cringeBlack : Colors.black),
                          ),
                          onTap: () {
                            setState(() {
                              gm.pieces[gm.lastMove.last]!.name = "queen";
                              gm.pieces[gm.lastMove.last]!.img = gm.cringeMode
                                  ? "images/cringeQ.png"
                                  : "images/q.png";
                              removeHighlightOverlay();
                            });
                            gm.check();
                          },
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 1.0,
                        height: deviceSize.height * .1 * 0.25,
                        color: Colors.blueGrey.withOpacity(0.5),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: (deviceSize.width * .6) / 4 * 0.65,
                        child: GestureDetector(
                          child: Image.asset(
                            gm.cringeMode
                                ? "images/cringeB.png"
                                : "images/b.png",
                            scale: .3,
                            color: !gm.turns
                                ? (gm.cringeMode ? cringeWhite : Colors.white)
                                : (gm.cringeMode ? cringeBlack : Colors.black),
                          ),
                          onTap: () {
                            setState(() {
                              gm.pieces[gm.lastMove.last]!.name = "bishop";
                              gm.pieces[gm.lastMove.last]!.img = gm.cringeMode
                                  ? "images/cringeB.png"
                                  : "images/b.png";
                              removeHighlightOverlay();
                            });
                            gm.check();
                          },
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 1.0,
                        height: deviceSize.height * .1 * 0.25,
                        color: Colors.blueGrey.withOpacity(0.5),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: (deviceSize.width * .6) / 4 * 0.65,
                        child: GestureDetector(
                          child: Image.asset(
                            gm.turns
                                ? (gm.cringeMode
                                    ? "images/cringeN1.png"
                                    : "images/n.png")
                                : (gm.cringeMode
                                    ? "images/cringeN3.png"
                                    : "images/n.png"),
                            scale: .3,
                            color: !gm.turns
                                ? (gm.cringeMode ? cringeWhite : Colors.white)
                                : (gm.cringeMode ? cringeBlack : Colors.black),
                          ),
                          onTap: () {
                            setState(() {
                              gm.pieces[gm.lastMove.last]!.name = "knight";
                              gm.pieces[gm.lastMove.last]!.img = gm.turns
                                  ? (gm.cringeMode
                                      ? "images/cringeN1.png"
                                      : "images/n.png")
                                  : (gm.cringeMode
                                      ? "images/cringeN3.png"
                                      : "images/n.png");
                              removeHighlightOverlay();
                            });
                            gm.check();
                          },
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 1.0,
                        height: deviceSize.height * .1 * 0.25,
                        color: Colors.blueGrey.withOpacity(0.5),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: (deviceSize.width * .6) / 4 * 0.65,
                        child: GestureDetector(
                          child: Image.asset(
                            gm.cringeMode
                                ? "images/cringeR.png"
                                : "images/r.png",
                            scale: .3,
                            color: !gm.turns
                                ? (gm.cringeMode ? cringeWhite : Colors.white)
                                : (gm.cringeMode ? cringeBlack : Colors.black),
                          ),
                          onTap: () {
                            setState(() {
                              gm.pieces[gm.lastMove.last]!.name = "rook";
                              gm.pieces[gm.lastMove.last]!.img = gm.cringeMode
                                  ? "images/cringeR.png"
                                  : "images/r.png";
                              removeHighlightOverlay();
                            });
                            gm.check();
                          },
                        ),
                      ),
                      Expanded(child: Container()),
                    ]),
              ),
            ],
          ),
        ),
      );
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    });
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void checkmateOverlay() {
    animationController.forward();
    overlayEntry = OverlayEntry(builder: (context) {
      return Scaffold(
        body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                    width: deviceSize.width * .61,
                    height: deviceSize.height * .4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF13151D),
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Color(0xFF2f3341),
                          height: deviceSize.height * .1,
                        ),
                        Container(
                          color: Color(0xFF13151D),
                          height: deviceSize.height * .3,
                        )
                      ],
                    )),
                Container(
                  width: deviceSize.width * .6,
                  height: deviceSize.height * .4,
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Text(
                        "Name Won",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: deviceSize.width*0.04,
                        ),
                      ),
                      Text(
                        "${gm.isCheckmate ? "By Checkmate" : "${WonOnTime ? "On Time" : "By Resignation"}"}",
                        style: TextStyle(
                          color: Color(0xFF535772),
                          fontSize: deviceSize.width*0.03,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: cringeBlack, width: 2.0)),
                                width: 74.0,
                                height: 74.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                width: 70.0,
                                height: 70.0,
                                child: Image.asset(
                                  "images/avatar1.jpg",
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              Container(
                                width: deviceSize.height*0.1,
                                height: deviceSize.height*0.18,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Abdallah Sayed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width*0.022,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "VS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceSize.width*0.04,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: cringeWhite, width: 2.0)),
                                width: 74.0,
                                height: 74.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                width: 70.0,
                                height: 70.0,
                                child: Image.asset(
                                  "images/avatar2.png",
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              Container(
                                width: deviceSize.height*0.1,
                                height: deviceSize.height*0.18,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Ismail Ibrahim",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width*0.022,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                        flex: 6,
                      ),
                      Container(
                          alignment: Alignment.center,
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
                          width: (deviceSize.width * .55),
                          height: (deviceSize.width * .115),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              removeHighlightOverlay();
                            },
                            child: Text(
                              "Rematch",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
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
                            width: (deviceSize.width * .26),
                            height: (deviceSize.width * .08),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                removeHighlightOverlay();
                              },
                              child: Text(
                                "New Game",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
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
                            width: (deviceSize.width * .26),
                            height: (deviceSize.width * .08),
                            child: Text(
                              "Game Review",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                        flex: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      );
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    });
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void drawOverlay() {
    animationController.forward();
    overlayEntry = OverlayEntry(builder: (context) {
      return Scaffold(
        body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                    width: deviceSize.width * .6,
                    height: deviceSize.height * .4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF13151D),
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Color(0xFF2f3341),
                          height: deviceSize.height * .1,
                        ),
                        Container(
                          color: Color(0xFF13151D),
                          height: deviceSize.height * .3,
                        )
                      ],
                    )),
                Container(
                  width: deviceSize.width * .61,
                  height: deviceSize.height * .4,
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Text(
                        "Game Drawn",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${gm.insufficientMaterial ? "By Insufficient Material" : "${gm.repetition ? "By Repetition" : "${gm.fiftyMoves ? "By Fifty Moves" : "${gm.isStalemate ? "By Stalemate" : "${DrawnOnTime ? "On Time" : "By Agreement"}"}"}"}"}",
                        style: TextStyle(
                          color: Color(0xFF535772),
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: cringeBlack, width: 2.0)),
                                width: 74.0,
                                height: 74.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                width: 70.0,
                                height: 70.0,
                                child: Image.asset(
                                  "images/avatar1.jpg",
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              Container(
                                width: deviceSize.height*0.1,
                                height: deviceSize.height*0.18,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Abdallah Sayed",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width*0.022,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "VS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceSize.width*0.04,
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: cringeWhite, width: 2.0)),
                                width: 74.0,
                                height: 74.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                width: 70.0,
                                height: 70.0,
                                child: Image.asset(
                                  "images/avatar2.png",
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              Container(
                                width: deviceSize.height*0.1,
                                height: deviceSize.height*0.18,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Ismail Ibrahim",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: deviceSize.width*0.022,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      Expanded(
                        child: Container(),
                        flex: 6,

                      ),
                      Container(
                          alignment: Alignment.center,
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
                          width: (deviceSize.width * .55),
                          height: (deviceSize.width * .115),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              removeHighlightOverlay();
                            },
                            child: Text(
                              "Rematch",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
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
                            width: (deviceSize.width * .28),
                            height: (deviceSize.width * .07),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                removeHighlightOverlay();
                              },
                              child: Text(
                                "New Game",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
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
                            width: (deviceSize.width * .28),
                            height: (deviceSize.width * .07),
                            child: Text(
                              "Game Review",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                        flex: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      );
      Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
    });
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  bool overlayOn = false;
  void removeHighlightOverlay() {
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    double containerSize = (deviceSize.width / 8) * .5;
    late Color color;
    List<String> letters = ["a", "b", "c", "d", "e", "f", "g", "h"];
    return Scaffold(
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
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xFF9799a0),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "${widget.gameType.time} • ${widget.gameType.name} • Rated",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9799a0))),
                          Text("Playing right now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF535772))),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border:
                                    Border.all(color: cringeBlack, width: 2.0)),
                            width: 54.0,
                            height: 54.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            width: 50.0,
                            height: 50.0,
                            child: Image.asset(
                              "images/avatar1.jpg",
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Abdallah Sayed",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                  color: Color(0xFFd9dadb))),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "831",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF535772)),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2f3341),
                          ),
                          height: 45,
                          width: 100,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  durationToText(blackTime),
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFFdbdcdd),
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  width: deviceSize.width * 0.9,
                  height: deviceSize.width * 0.9,
                  child: Stack(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 64,
                        physics:const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 8),
                        itemBuilder: (context, index) {
                          int a = index ~/ 8;
                          int b = (a % 2 == 0) ? 0 : 1;
                          if (index % 2 == b) {
                            color = const Color(0xff13151D);
                          } else {
                            color = const Color(0xFF2f3341);
                          }

                          return Stack(
                            children: [

                              Container(
                                color:color,
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds:200),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          gm.pieces[gm.translator(index)]!.name == "king" &&
                                            gm.pieces[gm.translator(index)]!.color ==
                                                gm.turns &&
                                            gm.isCheck?
                                              Color(0xFF613030):
                                          Color(0xFF615730).withOpacity(gm.lastMove.isNotEmpty ? (index ==
                                              gm.reversedTranslator(gm.lastMove.last) || index ==
                                              gm.reversedTranslator(
                                                  gm.lastMove[gm.lastMove.length - 2]) ? 0.8:0.0) : 0.0),
                                          Colors.transparent
                                        ]
                                    )
                                ),

                              ),
                              Center(
                                  child: gm.pieces[gm.translator(index)]!
                                      .img !=
                                      ""
                                      ? Draggable<Pieces>(
                                    onDragStarted: () {
                                      if (gm.turns ==
                                          gm
                                              .pieces[
                                          gm.translator(index)]!
                                              .color) {
                                        setState(() {
                                          gm.newPossible =
                                              gm.possibleMoves(
                                                  gm.pieces[
                                                  gm.translator(
                                                      index)],
                                                  index);
                                        });
                                      }
                                    },
                                    data:
                                    gm.pieces[gm.translator(index)],
                                    feedback: SizedBox(
                                      height: containerSize,
                                      width: containerSize,
                                      child: Stack(
                                        children: [
                                          ImageFiltered(
                                            imageFilter:
                                            ImageFilter.blur(
                                                sigmaY: 0.5,
                                                sigmaX: 0.5),
                                            child: Image.asset(
                                              gm
                                                  .pieces[gm.translator(
                                                  index)]!
                                                  .img,
                                              color: gm
                                                  .pieces[
                                              gm.translator(
                                                  index)]!
                                                  .color
                                                  ? (gm.cringeMode?cringeWhite:Colors.white)
                                                  : (gm.cringeMode?cringeBlack:Colors.black),
                                            ),
                                          ),
                                          Image.asset(
                                            gm
                                                .pieces[gm
                                                .translator(index)]!
                                                .img,
                                            color: gm
                                                .pieces[
                                            gm.translator(
                                                index)]!
                                                .color
                                                ? (gm.cringeMode?cringeWhite:Colors.white)
                                                : (gm.cringeMode?cringeBlack:Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    childWhenDragging: Container(),
                                    child: SizedBox(
                                      height: containerSize,
                                      width: containerSize,
                                      child: Image.asset(
                                        gm.pieces[gm.translator(index)]!
                                            .img,
                                        color: gm
                                            .pieces[gm
                                            .translator(index)]!
                                            .color
                                            ? (gm.cringeMode?cringeWhite:Colors.white)
                                            : (gm.cringeMode?cringeBlack:Colors.black),
                                      ),
                                    ),
                                  )
                                      : Container()),
                              gm.newPossible.contains(gm.translator(index))
                                  ?  Center(
                                      child: Icon(
                                      Icons.circle,
                                      color: Colors.red.withOpacity(0.5),
                                    ))
                                  : Container(),
                              DragTarget<Pieces>(
                                builder:
                                    (context, candidateData, rejectedData) {
                                  return Container();
                                },
                                onAccept: (piece) {
                                  setState(() {
                                    overlayOn = true;
                                    // checkmateOverlay();

                                    gm.turns = !gm.turns;
                                    gm.pieces[gm.translator(index)]!
                                            .isEmptyPiece
                                        ? null
                                        : gm.counter = 0;
                                    gm.pieces[gm.translator(index)] = piece;
                                    gm.pieces[piece.currentLocation] =
                                        Pieces.empty();
                                    if (piece.name == "king" &&
                                        gm.translator(index + 2) ==
                                            piece.currentLocation) {
                                      if (piece.color) {
                                        gm.pieces["c1"] = gm.pieces["a1"]!;
                                        gm.pieces["a1"] = Pieces.empty();
                                        gm.pieces["c1"]!.currentLocation =
                                            gm.translator(index);
                                      } else {
                                        gm.pieces["c8"] = gm.pieces["a8"]!;
                                        gm.pieces["a8"] = Pieces.empty();
                                        gm.pieces["c8"]!.currentLocation =
                                            gm.translator(index);
                                      }
                                    }
                                    if (piece.name == "king" &&
                                        gm.translator(index - 2) ==
                                            piece.currentLocation) {
                                      if (piece.color) {
                                        gm.pieces["e1"] = gm.pieces["h1"]!;
                                        gm.pieces["h1"] = Pieces.empty();
                                        gm.pieces["e1"]!.currentLocation =
                                            gm.translator(index);
                                      } else {
                                        gm.pieces["e8"] = gm.pieces["h8"]!;
                                        gm.pieces["h8"] = Pieces.empty();
                                        gm.pieces["e8"]!.currentLocation =
                                            gm.translator(index);
                                      }
                                    }
                                    if (gm.translator(index) == gm.enPassant) {
                                      !gm.turns
                                          ? gm.pieces[
                                                  gm.translator(index + 8)] =
                                              Pieces.empty()
                                          : gm.pieces[
                                                  gm.translator(index - 8)] =
                                              Pieces.empty();
                                    }
                                    gm.lastMove.add(piece.currentLocation);
                                    piece.currentLocation =
                                        gm.translator(index);
                                    gm.lastMove.add(piece.currentLocation);
                                    gm.lastPiece.add(piece);
                                    gm.newPossible = [];
                                    gm.check();
                                    if (piece.name == "pawn" &&
                                        (index <= 7 || index >= 56)) {
                                      overlayOn = true;
                                      promotionOverlay();
                                    }
                                    if (gm.isCheckmate) {
                                      overlayOn = true;
                                      checkmateOverlay();
                                    } else if (gm.isStalemate) {
                                      overlayOn = true;
                                      drawOverlay();
                                    } else if (gm.insufficientMaterial) {
                                      overlayOn = true;
                                      drawOverlay();
                                    } else if (gm.fiftyMoves) {
                                      overlayOn = true;
                                      drawOverlay();
                                    } else if (gm.repetition) {
                                      overlayOn = true;
                                      drawOverlay();
                                    }
                                  });

                                  gm.counter++;
                                },
                                onWillAccept: (piece) {
                                  return piece!.color == gm.turns &&
                                      gm.newPossible
                                          .contains(gm.translator(index));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      IgnorePointer(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: (deviceSize.width / 8) * .9,
                              child: Container(
                                padding: const EdgeInsets.all(1.0),
                                child: Text('${8 - index}',
                                    style: const TextStyle(
                                        color: Color(0xFF9799a0),
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: 8,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: IgnorePointer(
                          child: Row(
                            children: List.generate(
                                8,
                                (index) => SizedBox(
                                      width: (deviceSize.width / 8) * .9,
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(letters[index],
                                            style: const TextStyle(
                                                color: Color(0xFF9799a0),
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border:
                                    Border.all(color: cringeWhite, width: 2.0)),
                            width: 54.0,
                            height: 54.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            width: 50.0,
                            height: 50.0,
                            child: Image.asset(
                              "images/avatar2.png",
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Ismail Ibrahim",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                  color: Color(0xFFd9dadb))),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "625",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF535772)),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2f3341),
                          ),
                          height: 45,
                          width: 100,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  durationToText(whiteTime),
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFFdbdcdd),
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: GestureDetector(
                        // onTap: ,
                        child: Image.asset(
                          "images/list.png",
                          fit: BoxFit.fill,
                          color: const Color(0xFFdddedf),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "images/chat.png",
                        fit: BoxFit.fill,
                        color: const Color(0xFFdddedf),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "images/left-arrow.png",
                        fit: BoxFit.fill,
                        color: const Color(0xFFdddedf),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "images/right-arrow.png",
                        fit: BoxFit.fill,
                        color: const Color(0xFFdddedf),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          overlayOn
              ? AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaY: anim.value, sigmaX: anim.value),
                        child: Container(),
                      ))
              : Container()
        ],
      ),
    );
  }

  String durationToText(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours != 0 ? "${twoDigits(duration.inHours)}:" : ""}$twoDigitMinutes:$twoDigitSeconds";
  }
}

class glare extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = const Color(0xFF4A4E6D);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
