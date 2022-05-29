import 'dart:io';

import 'package:dio/dio.dart';
import 'package:viking_game/models/game.dart';
import 'package:viking_game/models/game_attribute.dart';
import 'package:viking_game/models/game_session.dart';
import 'package:viking_game/utilities/custom_exception.dart';
import 'package:viking_game/utilities/http_helper.dart';

const gameAPI = 'game';

class GameService {
  static Future<List<Game>> getGames() async {
    var response = await HTTPHelper.getRequest('$gameAPI', {});
    return (response as List).map((e) => Game.fromJson(e)).toList();
  }

  static Future<GameAttribute> createGameAttribute(
      GameAttribute gameAttribute) async {
    try {
      var response = await HTTPHelper.postRequest(
          '$gameAPI/createGameAttribute', gameAttribute);
      return GameAttribute.fromJson(response);
    } on CustomException catch (e) {
      throw CustomException(message: e.message, statusCode: e.statusCode);
    }
  }

  static Future<GameAttribute> updateGameAttribute(
      String id, GameAttribute gameAttribute) async {
    try {
      var response = await HTTPHelper.patchRequest(
          '$gameAPI/updateGameAttribute/$id', gameAttribute);
      return GameAttribute.fromJson(response);
    } on CustomException catch (e) {
      throw CustomException(message: e.message, statusCode: e.statusCode);
    }
  }

  static Future<GameAttribute?> getGameAttributes(String id) async {
    try {
      var response =
          await HTTPHelper.getRequest('$gameAPI/getGameAttributes/$id', {});
      if (response != "") return GameAttribute.fromJson(response);
      return null;
    } on CustomException catch (e) {
      throw CustomException(message: e.message, statusCode: e.statusCode);
    }
  }

  static Future<String> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName)
      });
      final response =
          await HTTPHelper.postRequest('$gameAPI/uploadGameImage', formData);
      return response['key'].split('/')[1];
    } on CustomException catch (e) {
      throw new CustomException(message: e.message, statusCode: e.statusCode);
    }
  }

  static Future<String> getImagePath(String keyFile) async {
    try {
      final response =
          await HTTPHelper.getRequest('$gameAPI/getGameImage/$keyFile', {});
      return response;
    } on CustomException catch (e) {
      throw new CustomException(message: e.message, statusCode: e.statusCode);
    }
  }

  static Future<bool> deleteGameAttribute(String gameId, int index) async {
    try {
      final response = await HTTPHelper.deleteRequest(
          '$gameAPI/deleteGameAttribute/$gameId', null, {'index': index});
      return response['ok'] == 1;
    } on CustomException catch (e) {
      throw new CustomException(message: e.message, statusCode: e.statusCode);
    }
  }

  static Future<GameSession> createGameSession(GameSession gameSession) async {
    try {
      final response = await HTTPHelper.postRequest(
          '$gameAPI/createGameSession', gameSession);
      return GameSession.fromJson(response);
    } on CustomException catch (e) {
      throw new CustomException(message: e.message, statusCode: e.statusCode);
    }
  }
}
