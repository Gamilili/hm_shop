import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs;
  updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
