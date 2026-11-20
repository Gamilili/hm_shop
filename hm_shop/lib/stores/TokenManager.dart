import 'package:hm_shop/contants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  //返回持久化对象的实例化对象
  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  String _token = "";

  init() async {
    SharedPreferences prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  Future<void> setToken(String val) async {
    SharedPreferences prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  String getToken() {
    return _token;
  }

  removeToken() async {
    SharedPreferences prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);
    _token = ""; //内存的删掉了
  }
}

final tokenManager = TokenManager();
