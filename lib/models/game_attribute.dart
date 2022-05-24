class GameAttribute {
  final String? id;
  final String gameId;
  String? baseImage;
  String? tempImageUrl;
  final bool isGlobal;
  final List<GamePoint> points;

  GameAttribute(
      {this.id,
      this.baseImage,
      this.tempImageUrl,
      required this.gameId,
      required this.isGlobal,
      required this.points});

  factory GameAttribute.fromJson(Map json) {
    var pointsList = (json['points'] as List);
    List<GamePoint> _points =
        pointsList.map((e) => GamePoint.fromJson(e)).toList();
    return GameAttribute(
        id: json['_id'] != null ? json['_id'] : json['id'],
        gameId: json['gameId'],
        isGlobal: json['isGlobal'],
        baseImage: json['baseImage'],
        points: _points);
  }

  Map<String, dynamic> toJson() => {
        'gameId': gameId,
        'isGlobal': isGlobal,
        'baseImage': baseImage,
        'points': points.map((e) => e.toJson()).toList()
      }..removeWhere((key, value) => key == null || value == null);
}

class GamePoint {
  String? layer;
  String? imageUrl;
  int index;
  int? score;
  double? dx;
  double? dy;
  double? scale;

  GamePoint(
      {required this.index,
      this.layer,
      this.imageUrl,
      this.score,
      this.dx,
      this.dy,
      this.scale});

  factory GamePoint.fromJson(Map json) {
    return GamePoint(
        index: json['index'],
        layer: json['layer'],
        score: json['score'],
        dx: json['dx'],
        dy: json['dy'],
        scale: json['scale'] != null ? json['scale'].toDouble() : null);
  }

  Map<String, dynamic> toJson() => {
        'layer': layer,
        'index': index,
        'score': score,
        'dx': dx,
        'dy': dy,
        'scale': scale
      }..removeWhere((key, value) => value == null);
}
