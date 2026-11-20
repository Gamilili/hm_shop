import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/utils/ToolUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryItem> categoryList = [];
  List<BannerItem> bannerList = [];
  //特惠推荐
  SuggestionResult suggestionResult = SuggestionResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 热榜推荐
  SuggestionResult _inVogueResult = SuggestionResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 一站式推荐
  SuggestionResult _oneStopResult = SuggestionResult(
    id: "",
    title: "",
    subTypes: [],
  );

  List<GoodDetailItem> _recommendList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _paddingTop = 100;
      _key.currentState?.show();
    });

    _regisisterEvert();
  }
  //创建时间initstate > build =>下拉刷新组件 =>才可以操作他

  //监听滚动到底部的方法
  void _regisisterEvert() {
    _controller.addListener(() {
      //滚动条到底部-50的地方就可以刷新
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        _getRecommendList();
      }
    });
  }

  Future<void> _getBannderList() async {
    bannerList = await getBannerListAPI();
  }

  Future<void> _getCategoryList() async {
    categoryList = await getCategoryListAPI();
  }

  Future<void> _getSuggestionList() async {
    suggestionResult = await getProductListAPI();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  //页码
  int _page = 1;
  //目前只能允许一个请求加载
  bool _isLoading = false;
  //是否有下一页
  bool _hasMore = true;
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int resquestList = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": resquestList});
    _isLoading = false;
    _hasMore = _recommendList.length >= resquestList;
    setState(() {});
    _page++;
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion(result: suggestionResult)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      HmMoreList(recommendList: _recommendList),
    ];
  }

  //下拉刷新
  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannderList();
    await _getCategoryList();
    //特惠推荐
    await _getSuggestionList();
    // 热榜推荐
    await _getInVogueList();
    // 一站式推荐
    await _getOneStopList();
    await _getRecommendList();
    ToolUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();
  //
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  double _paddingTop = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
