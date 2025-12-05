import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/hero_slider.dart';

void main() {
  group('HeroSlider', () {
    final testSlides = [
      const HeroSlide(
        imageUrl: 'https://example.com/image1.jpg',
        title: 'Slide 1',
      ),
      const HeroSlide(
        imageUrl: 'https://example.com/image2.jpg',
        title: 'Slide 2',
      ),
    ];

    testWidgets('should create HeroSlider instance', (tester) async {
      final slider = HeroSlider(
        slides: testSlides,
        isMobile: false,
        heroTitleSize: 32,
        heroSubtitleSize: 18,
        heroTop: 40,
      );
      expect(slider, isA<HeroSlider>());
      expect(slider, isNotNull);
    });

    testWidgets('should be a StatefulWidget', (tester) async {
      final slider = HeroSlider(
        slides: testSlides,
        isMobile: false,
        heroTitleSize: 32,
        heroSubtitleSize: 18,
        heroTop: 40,
      );
      expect(slider, isA<StatefulWidget>());
    });

    testWidgets('should require slides parameter', (tester) async {
      final slider = HeroSlider(
        slides: testSlides,
        isMobile: false,
        heroTitleSize: 32,
        heroSubtitleSize: 18,
        heroTop: 40,
      );
      expect(slider.slides, equals(testSlides));
    });

    testWidgets('should have default height', (tester) async {
      final slider = HeroSlider(
        slides: testSlides,
        isMobile: false,
        heroTitleSize: 32,
        heroSubtitleSize: 18,
        heroTop: 40,
      );
      expect(slider.height, 320);
    });

    test('should create HeroSlide instance', () {
      const slide = HeroSlide(
        imageUrl: 'https://example.com/image.jpg',
        title: 'Test Slide',
      );
      expect(slide, isA<HeroSlide>());
      expect(slide.imageUrl, 'https://example.com/image.jpg');
      expect(slide.title, 'Test Slide');
    });
  });
}
