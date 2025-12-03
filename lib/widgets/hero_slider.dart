import 'dart:async';
import 'package:flutter/material.dart';

class HeroSlide {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final VoidCallback? onPrimary;
  final VoidCallback? onSecondary;
  final String primaryLabel;
  final String? secondaryLabel;

  const HeroSlide({
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.onPrimary,
    this.onSecondary,
    this.primaryLabel = 'Shop now',
    this.secondaryLabel,
  });
}

class HeroSlider extends StatefulWidget {
  final List<HeroSlide> slides;
  final double height;
  final Duration autoPlayInterval;
  final bool autoPlay;

  const HeroSlider({
    Key? key,
    required this.slides,
    this.height = 320,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlay = true,
  }) : super(key: key);

  @override
  _HeroSliderState createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  late final PageController _controller;
  late int _currentIndex;
  Timer? _timer;
  bool _userInteracting = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: 0);
    if (widget.autoPlay && widget.slides.length > 1) {
      _startAutoPlay();
    }
  }
