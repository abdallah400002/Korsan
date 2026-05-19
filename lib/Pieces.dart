class Pieces {
  bool isEmptyPiece = true;
  bool color = false;
  String name = "";
  String img = "";
  String currentLocation = "";
  List<int> possibleMoves = [];
  int? num;

  Pieces(this.color, this.name, this.img, this.currentLocation, {this.num}) {
    isEmptyPiece = false;
  }

  Pieces.empty();
}
