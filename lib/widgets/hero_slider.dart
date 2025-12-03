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
