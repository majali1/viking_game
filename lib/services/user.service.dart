
import 'package:viking_game/dtos/login.dto.dart';
import 'package:viking_game/models/vuser.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/custom_exception.dart';
import 'package:viking_game/utilities/http_helper.dart';
import 'package:viking_game/utilities/sharedpref.dart';

const userAPI = 'user';
const authAPI = 'auth';

class UserService {
  static Future<VUser> loginUser(LoginDTO dto) async {
    try{
      final response = await HTTPHelper.postRequest('auth/login', dto);
      VUser user = VUser.fromJson(response[SharedKeys.user]);
      SharedPrefrencesHelper.setToken(response[SharedKeys.token]);
      SharedPrefrencesHelper.setUserInfo(user);
      return user;
    } on CustomException catch(e){
      throw new CustomException(
          message: '${e.message}', statusCode: errorCode);
    }
  }
}