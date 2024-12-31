import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CarImageCarousel extends StatefulWidget {
  final List<String> carImages;

  const CarImageCarousel({Key? key, required this.carImages}) : super(key: key);

  @override
  _CarImageCarouselState createState() => _CarImageCarouselState();
}

class _CarImageCarouselState extends State<CarImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.carImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                child: Image.asset(
                  widget.carImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.carImages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 12.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppPalette.primaryColor
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
