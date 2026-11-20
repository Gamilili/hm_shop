import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({super.key, required this.bannerList});

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  Widget _getSliver() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: widget.bannerList
          .map(
            (e) =>
                Image.network(e.imgUrl!, fit: BoxFit.cover, width: screenWidth),
          )
          .toList(),
      carouselController: _controller,
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
        autoPlayInterval: Duration(seconds: 1),
        autoPlay: true,
        viewportFraction: 1.0,
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      left: 20,
      top: 20,
      child: SizedBox(
        width: 200,
        height: 36,
        child: TextField(
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: '搜索...',
            hintStyle: const TextStyle(color: Colors.white70, fontSize: 14),
            filled: true,
            fillColor: const Color.fromRGBO(0, 0, 0, 0.35),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getData() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.bannerList.map((e) {
            return GestureDetector(
              onTap: () {
                _controller.jumpToPage(widget.bannerList.indexOf(e));
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: widget.bannerList.indexOf(e) == _currentIndex ? 40 : 20,
                height: 6,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: widget.bannerList.indexOf(e) == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSliver(), _getSearch(), _getData()]);
  }
}
