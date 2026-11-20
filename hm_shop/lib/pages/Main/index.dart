import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  //定义数据 ,渲染导航
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_home.png",
      "active": "lib/assets/ic_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_cart.png",
      "active": "lib/assets/ic_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_process.png",
      "active": "lib/assets/ic_process_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_my.png",
      "active": "lib/assets/ic_my_active.png",
      "text": "我的",
    },
  ];
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _getTabBar() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]['icon']!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]['active']!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    super.initState();
    // 初始化token
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken() != "") {
      // 调用获取用户信息接口
      _userController.updateUserInfo(await getUserInfoAPI());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        items: _getTabBar(),
        currentIndex: _currentIndex,
      ),
    );
  }
}
