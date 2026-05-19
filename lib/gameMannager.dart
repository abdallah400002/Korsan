import 'package:chess/Pieces.dart';
import 'package:chess/inGame.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class gameMannager {
  Map<String, Pieces> pieces = {};
  Map<String, String> checkPieces = {};
  List<String> enemyPossible = [];
  List<String> newPossible = [];
  List<String> currentWhite = [];
  List<String> lastMove = [];
  List<Pieces> lastPiece = [];
  String whiteEnPassant = "";
  String blackEnPassant = "";
  String enPassant = "";
  bool turns = true;
  bool isCheck = false;
  bool isCheckmate = false;
  bool isStalemate = false;
  bool insufficientMaterial = false;
  bool fiftyMoves = false;
  bool repetition = false;
  int counter = 0;
  int w = 0;
  int b = 0;
  bool empty = false;
  bool cringeMode = false;

  void check() {
    enemyPossible = [];
    isCheck = false;
    isCheckmate = true;
    isStalemate = true;
    for (int i = 0; i < 64; i++) {
      if (pieces[translator(i)]!.color != turns &&
          pieces[translator(i)]!.name.isNotEmpty) {
        if (possibleMoves(pieces[translator(i)], i).contains(pieces.keys
            .firstWhere((element) =>
        pieces[element]!.name == "king" &&
            pieces[element]!.color == turns))) {
          checkPieces[translator(i)] = pieces[translator(i)]!.name;
          isCheck = true;
          counter = 0;
        }
        enemyPossible += possibleMoves(pieces[translator(i)], i, enemyP: true);
      }
    }

    w = 0;
    b = 0;
    empty = false;

    for (int i = 0; i < 64; i++) {
      if (pieces[translator(i)]!.color == turns &&
          pieces[translator(i)]!.name.isNotEmpty) {
        if (possibleMoves(pieces[translator(i)], i).isNotEmpty || isCheck) {
          isStalemate = false;
        }
        if (possibleMoves(pieces[translator(i)], i).isNotEmpty) {
          isCheckmate = false;
        }
      }
      if (pieces[translator(i)]!.isEmptyPiece ||
          pieces[translator(i)]!.name != "pawn" ||
          pieces[translator(i)]!.name != "rook" ||
          pieces[translator(i)]!.name != "queen") {
        empty = true;
      }
      if (!pieces[translator(i)]!.isEmptyPiece &&
          pieces[translator(i)]!.name != "pawn" &&
          pieces[translator(i)]!.name != "rook" &&
          pieces[translator(i)]!.name != "queen") {
        if (pieces[translator(i)]!.color) {
          w++;
        } else {
          b++;
        }
      }
    }
    if (w <= 2 && b <= 2 && empty) {
      insufficientMaterial = true;
    }

    else if (lastPiece.length >= 9) {
      if (lastPiece[lastPiece.length - 9].name ==
          lastPiece[lastPiece.length - 7].name &&
          lastPiece[lastPiece.length - 7].name ==
              lastPiece[lastPiece.length - 5].name &&
          lastPiece[lastPiece.length - 5].name ==
              lastPiece[lastPiece.length - 3].name &&
          lastPiece[lastPiece.length - 3].name == lastPiece.last.name &&
          lastPiece[lastPiece.length - 8].name ==
              lastPiece[lastPiece.length - 6].name &&
          lastPiece[lastPiece.length - 6].name ==
              lastPiece[lastPiece.length - 4].name &&
          lastPiece[lastPiece.length - 4].name ==
              lastPiece[lastPiece.length - 2].name &&
          lastPiece[lastPiece.length - 9].currentLocation ==
              lastPiece[lastPiece.length - 5].currentLocation &&
          lastPiece[lastPiece.length - 5].currentLocation ==
              lastPiece.last.currentLocation &&
          lastPiece[lastPiece.length - 7].currentLocation ==
              lastPiece[lastPiece.length - 3].currentLocation &&
          lastMove[lastMove.length - 16] == lastMove[lastMove.length - 11] &&
          lastMove[lastMove.length - 15] == lastMove[lastMove.length - 12]) {
        repetition = true;
      }
    }
    if (counter == 50) {
      fiftyMoves = true;
    }

    //   if (draw) {
    //     inGame;
    //   } else if (isStalemate) {
    //     print("stalemate");
    //   } else if (isCheckmate) {
    //     print("Checkmate");
    //   }
    // }
  }

  void init() {
    for (int i = 0; i < 64; i++) {
      pieces[translator(i)] = Pieces.empty();
    }

    Pieces wr1 = Pieces(true, "rook", cringeMode?"images/cringeR.png":"images/r.png", "a1", num: 1);
    Pieces wn1 = Pieces(true, "knight", cringeMode?"images/cringeN1.png":"images/n.png", "b1");
    Pieces wb1 = Pieces(true, "bishop", cringeMode?"images/cringeB.png":"images/b.png", "c1");
    Pieces wk = Pieces(true, "king",cringeMode?"images/cringeK.png":"images/k.png", "d1");
    Pieces wq = Pieces(true, "queen", cringeMode?"images/cringeQ.png":"images/q.png", "e1");
    Pieces wb2 = Pieces(true, "bishop", cringeMode?"images/cringeB.png":"images/b.png", "f1");
    Pieces wn2 = Pieces(true, "knight", cringeMode?"images/cringeN2.png":"images/n.png", "g1");
    Pieces wr2 = Pieces(true, "rook", cringeMode?"images/cringeR.png":"images/r.png", "h1", num: 2);

    Pieces wp1 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "a2");
    Pieces wp2 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "b2");
    Pieces wp3 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "c2");
    Pieces wp4 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "d2");
    Pieces wp5 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "e2");
    Pieces wp6 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "f2");
    Pieces wp7 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "g2");
    Pieces wp8 = Pieces(true, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "h2");

    Pieces br1 = Pieces(false, "rook", cringeMode?"images/cringeR.png":"images/r.png", "a8", num: 1);
    Pieces bn1 = Pieces(false, "knight", cringeMode?"images/cringeN4.png":"images/n.png", "b8");
    Pieces bb1 = Pieces(false, "bishop", cringeMode?"images/cringeB.png":"images/b.png", "c8");
    Pieces bk = Pieces(false, "king", cringeMode?"images/cringeK.png":"images/k.png", "d8");
    Pieces bq = Pieces(false, "queen", cringeMode?"images/cringeQ.png":"images/q.png", "e8");
    Pieces bb2 = Pieces(false, "bishop", cringeMode?"images/cringeB.png":"images/b.png", "f8");
    Pieces bn2 = Pieces(false, "knight", cringeMode?"images/cringeN3.png":"images/n.png", "g8");
    Pieces br2 = Pieces(false, "rook", cringeMode?"images/cringeR.png":"images/r.png", "h8", num: 2);

    Pieces bp1 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "a7");
    Pieces bp2 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "b7");
    Pieces bp3 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "c7");
    Pieces bp4 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "d7");
    Pieces bp5 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "e7");
    Pieces bp6 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "f7");
    Pieces bp7 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "g7");
    Pieces bp8 = Pieces(false, "pawn", cringeMode?"images/cringeP.png":"images/p.png", "h7");

    pieces["a1"] = wr1;
    pieces["b1"] = wn1;
    pieces["c1"] = wb1;
    pieces["d1"] = wk;
    pieces["e1"] = wq;
    pieces["f1"] = wb2;
    pieces["g1"] = wn2;
    pieces["h1"] = wr2;

    pieces["a2"] = wp1;
    pieces["b2"] = wp2;
    pieces["c2"] = wp3;
    pieces["d2"] = wp4;
    pieces["e2"] = wp5;
    pieces["f2"] = wp6;
    pieces["g2"] = wp7;
    pieces["h2"] = wp8;

    pieces["a8"] = br1;
    pieces["b8"] = bn1;
    pieces["c8"] = bb1;
    pieces["d8"] = bk;
    pieces["e8"] = bq;
    pieces["f8"] = bb2;
    pieces["g8"] = bn2;
    pieces["h8"] = br2;

    pieces["a7"] = bp1;
    pieces["b7"] = bp2;
    pieces["c7"] = bp3;
    pieces["d7"] = bp4;
    pieces["e7"] = bp5;
    pieces["f7"] = bp6;
    pieces["g7"] = bp7;
    pieces["h7"] = bp8;
  }

  List<int> xy(int index) {
    return [-(index % 8), -(index ~/ 8)];
  }

  int reversedXY(int x, int y) {
    return -(y * 8 + x);
  }

  String translator(int index) {
    List<String> b = ["a", "b", "c", "d", "e", "f", "g", "h"];
    List<int> a = [8, 7, 6, 5, 4, 3, 2, 1];
    return b[index % 8] + a[index ~/ 8].toString();
  }

  int reversedTranslator(String location) {
    List<String> cols = ["a", "b", "c", "d", "e", "f", "g", "h"];
    List<int> rows = [8, 7, 6, 5, 4, 3, 2, 1];
    int n = int.parse(location[1]);
    String l = location[0];
    int k = 0;
    int m = 0;
    for (int a = 0; a < 8; a++) {
      if (n == rows[a]) {
        k = a;
      }
      if (l == cols[a]) {
        m = a;
      }
    }
    return k * 8 + m;
  }

  List<String> possibleMoves(currentPiece, index,
      {bool filter = true, bool enemyP = false}) {
    List<String> ss = [];
    List<String> cols = ["a", "b", "c", "d", "e", "f", "g", "h"];
    List<int> rows = [1, 2, 3, 4, 5, 6, 7, 8];
    String t = translator(index);
    int n = int.parse(t[1]);
    String l = t[0];
    int k = 0;
    int m = 0;
    for (int a = 0; a < 8; a++) {
      if (n == rows[a]) {
        k = a;
      }
      if (l == cols[a]) {
        m = a;
      }
    }
    List<String> enemyCheckers = [];
    List<String> epFilter = [];
    List<String> ab = [];
    if (filter) {
      for (int i = 0; i < 64; i++) {
        String kingLocation = pieces.keys.firstWhere((element) =>
        pieces[element]!.name == "king" && pieces[element]!.color == turns);
        if (pieces[translator(i)]!.color != turns &&
            pieces[translator(i)]!.name.isNotEmpty) {
          epFilter = possibleMoves(pieces[translator(i)], i, filter: false);
          for (String c in epFilter) {
            if (c == kingLocation) {
              enemyCheckers.add(translator(i));
              if(pieces[translator(i)]!.name != 'knight'){
                List<int> kingXY = xy(reversedTranslator(kingLocation));
                List<int> pieceXY = xy(i);
                if (kingXY[1] == pieceXY[1]) {
                  for (int i = min(kingXY[0], pieceXY[0]);
                      i < max(kingXY[0], pieceXY[0]);
                      i++) {
                    ab.add(translator(reversedXY(i, kingXY[1])));
                  }
                } else if (kingXY[0] == pieceXY[0]) {
                  for (int i = min(kingXY[1], pieceXY[1]);
                      i < max(kingXY[1], pieceXY[1]);
                      i++) {
                    ab.add(translator(reversedXY(kingXY[0], i)));
                  }
                } else {
                  int s = (kingXY[1] - pieceXY[1]).abs() ~/
                      (kingXY[0] - pieceXY[0]);
                  for (int i = min(kingXY[0], pieceXY[0]);
                      i < max(kingXY[0], pieceXY[0]);
                      i++) {
                    int y = -((s * (kingXY[0] - i) + kingXY[1]).abs());
                    ab.add(translator(reversedXY(i, y)));
                  }
                }
              }
              ab = ab
                  .where((element) =>
              element != kingLocation && element != translator(i))
                  .toList();
            }
          }
        }
      }
    }
    switch (pieces[translator(index)]!.name) {
      case "pawn":
        if (currentPiece.color == true && !enemyP && k + 1 <= 6) {
          ss += ["${cols[(m)]}${rows[k + 1]}"];
        }
        if (currentPiece.color == false && !enemyP && k - 1 >= 0) {
          ss += ["${cols[(m)]}${rows[k - 1]}"];
        }
        if (rows[k] == 2 &&
            ss.contains("${cols[(m)]}${rows[k + 1]}") &&
            currentPiece.color) {
          ss += ["${cols[(m)]}${rows[(k + 2)]}"];
        }
        if (rows[k] == 7 &&
            ss.contains("${cols[(m)]}${rows[k - 1]}") &&
            !currentPiece.color) {
          ss += ["${cols[(m)]}${rows[(k - 2)]}"];
        }
        ss = ss
            .where((element) =>
        !(currentPiece.color != pieces[element]!.color &&
            pieces[element]!.name.isNotEmpty))
            .toList();

        if (currentPiece.color) {
          if (m - 1 >= 0 && k + 1 <= 7) {
            if ((pieces["${cols[(m - 1)]}${rows[(k + 1)]}"]?.name != "" &&
                pieces["${cols[(m - 1)]}${rows[(k + 1)]}"]!.color !=
                    currentPiece.color) ||
                enemyP) {
              ss.add("${cols[(m - 1)]}${rows[(k + 1)]}");
            }
          }
          if (m + 1 <= 7 && k + 1 <= 7) {
            if ((pieces["${cols[(m + 1)]}${rows[(k + 1)]}"]?.name != "" &&
                pieces["${cols[(m + 1)]}${rows[(k + 1)]}"]!.color !=
                    currentPiece.color) ||
                enemyP) {
              ss.add("${cols[(m + 1)]}${rows[(k + 1)]}");
            }
          }
        } else {
          if (m - 1 >= 0 && k - 1 >= 0) {
            if ((pieces["${cols[(m - 1)]}${rows[(k - 1)]}"]?.name != "" &&
                pieces["${cols[(m - 1)]}${rows[(k - 1)]}"]!.color !=
                    currentPiece.color) ||
                enemyP) {
              ss.add("${cols[(m - 1)]}${rows[(k - 1)]}");
            }
          }
          if (m + 1 <= 7 && k - 1 >= 0) {
            if ((pieces["${cols[(m + 1)]}${rows[(k - 1)]}"]?.name != "" &&
                pieces["${cols[(m + 1)]}${rows[(k - 1)]}"]!.color !=
                    currentPiece.color) ||
                enemyP) {
              ss.add("${cols[(m + 1)]}${rows[(k - 1)]}");
            }
          }
        }

        if (lastMove.length > 1 &&
            lastPiece.last.name == "pawn" &&
            (reversedTranslator(lastMove.last) -
                reversedTranslator(lastMove[lastMove.length - 2]))
                .abs() ==
                16) {
          if (m + 1 <= 7 && lastMove.last == "${cols[(m + 1)]}${rows[(k)]}") {
            enPassant = translator(((((reversedTranslator(lastMove.last) -
                reversedTranslator(lastMove[lastMove.length - 2])) /
                2) +
                reversedTranslator(lastMove[lastMove.length - 2]))
                .toInt()));
            ss.add(enPassant);
          }
          else
          if (m - 1 >= 0 && lastMove.last == "${cols[(m - 1)]}${rows[(k)]}") {
            enPassant = translator(((((reversedTranslator(lastMove.last) -
                reversedTranslator(lastMove[lastMove.length - 2])) /
                2) +
                reversedTranslator(lastMove[lastMove.length - 2]))
                .toInt()));
            ss.add(enPassant);
          }
        }

        break;

      case "rook":
        {
          for (int a = 1; a < 8; a++) {
            if (m + a <= 7) {
              ss += ["${cols[(m + a)]}${rows[(k)]}"];
              if (pieces["${cols[(m + a)]}${rows[(k)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (k + a <= 7) {
              ss.add("${cols[(m)]}${rows[(k + a)]}");
              if (pieces["${cols[(m)]}${rows[(k + a)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (k - a >= 0) {
              ss += ["${cols[(m)]}${rows[(k - a)]}"];
              if (pieces["${cols[(m)]}${rows[(k - a)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m - a >= 0) {
              ss += ["${cols[(m - a)]}${rows[(k)]}"];
              if (pieces["${cols[(m - a)]}${rows[(k)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }
        }
        break;

      case "knight":
        {
          if (m + 2 <= 7 && k + 1 < 8) {
            ss += ["${cols[m + 2]}${rows[k + 1]}"];
          }
          if (m + 2 <= 7 && k - 1 >= 0) {
            ss += ["${cols[m + 2]}${rows[k - 1]}"];
          }
          if (m - 2 >= 0 && k + 1 <= 7) {
            ss += ["${cols[m - 2]}${rows[k + 1]}"];
          }
          if (m - 2 >= 0 && k - 1 >= 0) {
            ss += ["${cols[m - 2]}${rows[k - 1]}"];
          }

          if (m + 1 <= 7 && k + 2 <= 7) {
            ss += ["${cols[m + 1]}${rows[k + 2]}"];
          }
          if (m - 1 >= 0 && k + 2 <= 7) {
            ss += ["${cols[m - 1]}${rows[k + 2]}"];
          }
          if (m + 1 <= 7 && k - 2 >= 0) {
            ss += ["${cols[m + 1]}${rows[k - 2]}"];
          }
          if (m - 1 >= 0 && k - 2 >= 0) {
            ss += ["${cols[m - 1]}${rows[k - 2]}"];
          }
        }
        break;

      case "bishop":
        {
          for (int a = 1; a < 8; a++) {
            if (m + a <= 7 && k - a >= 0) {
              ss += ["${cols[(m + a)]}${rows[(k - a)]}"];
              if (pieces["${cols[(m + a)]}${rows[(k - a)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m - a >= 0 && k + a <= 7) {
              ss += ["${cols[(m - a)]}${rows[(k + a)]}"];
              if (pieces["${cols[(m - a)]}${rows[(k + a)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m - a >= 0 && k - a >= 0) {
              ss += ["${cols[(m - a)]}${rows[(k - a)]}"];
              if (pieces["${cols[(m - a)]}${rows[(k - a)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m + a <= 7 && k + a <= 7) {
              ss += ["${cols[(m + a)]}${rows[(k + a)]}"];
              if (pieces["${cols[(m + a)]}${rows[(k + a)]}"]!.name != "" &&
                  filter) {
                break;
              }
            }
          }
        }
        break;

      case "queen":
        {
          for (int a = 1; a < 8; a++) {
            if (m + a <= 7 && k - a >= 0) {
              ss += ["${cols[(m + a)]}${rows[(k - a)]}"];
              if ((pieces["${cols[(m + a)]}${rows[(k - a)]}"]!.name != "" &&
                  filter  ) ) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m - a >= 0 && k + a <= 7) {
              ss += ["${cols[(m - a)]}${rows[(k + a)]}"];
              if (pieces["${cols[(m - a)]}${rows[(k + a)]}"]!.name != "" &&
                  filter) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m - a >= 0 && k - a >= 0) {
              ss += ["${cols[(m - a)]}${rows[(k - a)]}"];
              if (pieces["${cols[(m - a)]}${rows[(k - a)]}"]!.name != "" &&
                  filter) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m + a <= 7 && k + a <= 7) {
              ss += ["${cols[(m + a)]}${rows[(k + a)]}"];
              if (pieces["${cols[(m + a)]}${rows[(k + a)]}"]!.name != "" &&
                  filter) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m + a <= 7) {
              ss += ["${cols[(m + a)]}${rows[(k)]}"];
              if (pieces["${cols[(m + a)]}${rows[(k)]}"]!.name != "" &&
                  filter) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (k + a <= 7) {
              ss += ["${cols[(m)]}${rows[(k + a)]}"];
              if (pieces["${cols[(m)]}${rows[(k + a)]}"]!.name != "" &&
                  filter) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (k - a >= 0) {
              ss += ["${cols[(m)]}${rows[(k - a)]}"];
              if (pieces["${cols[(m)]}${rows[(k - a)]}"]!.name != "" &&
                  filter) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }

          for (int a = 1; a < 8; a++) {
            if (m - a >= 0) {
              ss += ["${cols[(m - a)]}${rows[(k)]}"];
              if ((pieces["${cols[(m - a)]}${rows[(k)]}"]!.name != "" &&
                  filter)  ) {
                if(!(pieces[ss.last]!.name == "king") ){
                  break;
                }
              }
            }
          }
        }
        break;

      case "king":
        if (m + 1 <= 7) {
          ss += ["${cols[(m + 1)]}${rows[(k)]}"];
        }
        if (m - 1 >= 0) {
          ss += ["${cols[(m - 1)]}${rows[(k)]}"];
        }
        if (k + 1 <= 7) {
          ss += ["${cols[(m)]}${rows[(k + 1)]}"];
        }
        if (k - 1 >= 0) {
          ss += ["${cols[(m)]}${rows[(k - 1)]}"];
        }

        if (m + 1 <= 7 && k + 1 <= 7) {
          ss += ["${cols[(m + 1)]}${rows[(k + 1)]}"];
        }
        if (m + 1 <= 7 && k - 1 >= 0) {
          ss += ["${cols[(m + 1)]}${rows[(k - 1)]}"];
        }
        if (m - 1 >= 0 && k + 1 <= 7) {
          ss += ["${cols[(m - 1)]}${rows[(k + 1)]}"];
        }
        if (m - 1 >= 0 && k - 1 >= 0) {
          ss += ["${cols[(m - 1)]}${rows[(k - 1)]}"];
        }

        turns ? ss.addAll(["b1", "f1"]) : ss.addAll(["b8", "f8"]);

        for (Pieces c in lastPiece) {
          if ((((c.name == "rook" && c.num == 1) || c.name == "king") ||
              (pieces["a1"]!.name != "rook" && turns) ||
              (pieces["a8"]!.name != "rook" && !turns))|| isCheck) {
            c.color ? ss.remove("b1") : ss.remove("b8");
          } else if ((((c.name == "rook" && c.num == 2) || c.name == "king") ||
              (pieces["h1"]!.name != "rook" && turns) ||
              (pieces["h8"]!.name != "rook" && !turns))|| isCheck) {
            c.color ? ss.remove("f1") : ss.remove("f8");
          }
        }

        for (String a in enemyPossible) {
          ss.remove(a);
        }

        if (!pieces["c1"]!.isEmptyPiece || !ss.contains("c1")) {
          ss.remove("b1");
        }
        if (!pieces["e1"]!.isEmptyPiece || !ss.contains("e1")) {
          ss.remove("f1");
        }
        if (!pieces["c8"]!.isEmptyPiece || !ss.contains("c8")) {
          ss.remove("b8");
        }
        if (!pieces["e8"]!.isEmptyPiece || !ss.contains("e8")) {
          ss.remove("f8");
        }
        break;
    }

    ss = ss.where((element) {
      if (!pieces[element]!.isEmptyPiece && !enemyP) {
        return pieces[element]!.color != currentPiece.color;
      }
      return true;
    }).toList();


    if (ab.isNotEmpty) {
      if (ab
          .where((element) => pieces[element]!.name.isNotEmpty)
          .length < 2 &&
          currentPiece.color == turns && currentPiece.name == "king" &&
          (isCheck ||
              (!isCheck && ab.contains(currentPiece.currentLocation)))) {
        for (String c in ab) {
          ss.remove(c);
        }
      }
      if (ab
          .where((element) => pieces[element]!.name.isNotEmpty)
          .length < 2 &&
          currentPiece.color == turns && currentPiece.name != "king" &&
          (isCheck ||
              (!isCheck && ab.contains(currentPiece.currentLocation)))) {
        ss = ss.where((element) =>
         (enemyCheckers.contains(element)||ab.contains(element)))
            .toList();
      }
    }
    else if (enemyCheckers.isNotEmpty &&
        currentPiece.color == turns &&
        currentPiece.name != "king") {
      ss = ss.where((element) => enemyCheckers.contains(element)).toList();
    }
    if (enemyCheckers.length >= 2 &&
        currentPiece.name != "king" &&
        currentPiece.color == turns) {
      ss = [];
    }
    return ss;
  }
}