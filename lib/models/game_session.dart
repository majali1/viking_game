class GameSession {
  final String userId;
  final int time;

  GameSession({required this.userId, required this.time});

  factory GameSession.fromJson(Map json) {
    return GameSession(userId: json['userId'], time: json['time']);
  }

  Map<String, dynamic> toJson() => {'time': time, 'userId': userId};
}
