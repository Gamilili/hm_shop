import 'package:hm_shop/contants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<GoodsDetailItems> getGuessListAPI(Map<String, dynamic> params) async {
  return GoodsDetailItems.fromJson(
    await dioRequest.get(HttpConstants.GUESS_LIST, queryParameters: params),
  );
}
