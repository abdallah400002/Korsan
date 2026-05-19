import 'package:flutter/material.dart';

import 'Home.dart';
import 'inGame.dart';

class GamePickerOverlay extends StatefulWidget {
  const GamePickerOverlay({Key? key}) : super(key: key);

  @override
  State<GamePickerOverlay> createState() => _GamePickerOverlayState();
}

class _GamePickerOverlayState extends State<GamePickerOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                width: deviceSize.width * .7,
                height: deviceSize.height * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF13151D),
                ),
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Stack(
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
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/bullet.png",
                                    color: const Color(0xFFa58a45),
                                    scale: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("Bullet",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                              const Text(
                                "1 min",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => inGame(GameType(
                                    Duration(minutes: 1),
                                    "1 Min",
                                    "Bullet",
                                  ))));
                              removeHighlightOverlay();
                            },
                          ),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 1.0,
                      width: deviceSize.height * .1 * 0.25,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                    Expanded(child: Container()),
                    Stack(
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
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/flash.png",
                                    color: Color(0xFFffc800),
                                    scale: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("Blitz",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                              const Text(
                                "3 min",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => inGame(GameType(
                                    Duration(minutes: 3),
                                    "3 Min",
                                    "Blitz",
                                  ))));
                              removeHighlightOverlay();
                            },
                          ),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: deviceSize.height * .1 * 0.25,
                      height: 1.0,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                    Expanded(child: Container()),
                    Stack(
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
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/stopwatch.png",
                                    color: Color(0xFF74944d),
                                    scale: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("Rapid",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                              const Text(
                                "10 min",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => inGame(GameType(
                                    Duration(minutes: 10),
                                    "10 Min",
                                    "Rapid",
                                  ))));
                              removeHighlightOverlay();
                            },
                          ),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: deviceSize.height * .1 * 0.25,
                      height: 1.0,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                    Expanded(child: Container()),
                    Stack(
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
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/sunny.png",
                                    scale: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("Daily",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              ),
                              const Text(
                                "1 Day",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (deviceSize.width * .4),
                          height: (deviceSize.width * .2),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => inGame(GameType(
                                    Duration(days: 1),
                                    "1 Day",
                                    "Day",
                                  ))));
                              removeHighlightOverlay();
                            },
                          ),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF2D313E), Color(0xFF13151D)],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0, 0.6],
                              tileMode: TileMode.clamp)),
                      width: (deviceSize.width * .65),
                      height: (deviceSize.width * .1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container()),
                          Image.asset(
                            "images/link.png",
                            scale: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                           Text("Create Challenge Link",
                              style: TextStyle(
                                  fontSize: deviceSize.width*0.04, color: Colors.white)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: Color(0xFFb9b8b4)),

                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Text("Cringe mode",style: TextStyle(
                        fontSize: deviceSize.width*0.03, color: Colors.white)),
                        Switch(
                          value: gm.cringeMode,
                          activeColor: Color(0xFF2D313E),
                          onChanged: (bool value) {
                            setState(() {
                              gm.cringeMode =value ;
                              // value = !gm.cringeMode;
                            });
                          },
                        ),
                        Expanded(child: Container()),

                      ],
                    ),

                    // SwitchListTile(
                    //   title: const Text('Lights'),
                    //   value: gm.cringeMode,
                    //   onChanged: (bool value) {
                    //     setState(() {
                    //       gm.cringeMode = value;
                    //     });
                    //   },
                    //   secondary: const Icon(Icons.lightbulb_outline),
                    // ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
  void removeHighlightOverlay() {
    animationController.reverse();
  }
}
