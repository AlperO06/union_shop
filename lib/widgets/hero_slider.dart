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
    this.autoPlayInterval = const Duration(seconds: 8),
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

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (t) {
      if (_userInteracting) return;
      final next = (_currentIndex + 1) % widget.slides.length;
      _controller.animateToPage(next, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slides.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: Container(
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: const Text('No slides available'),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: GestureDetector(
        onPanDown: (_) {
          _userInteracting = true;
          _stopAutoPlay();
        },
        onPanCancel: () {
          _userInteracting = false;
          if (widget.autoPlay && widget.slides.length > 1) _startAutoPlay();
        },
        onPanEnd: (_) {
          _userInteracting = false;
          if (widget.autoPlay && widget.slides.length > 1) _startAutoPlay();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.slides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final slide = widget.slides[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      slide.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.25),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slide.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(0, 1))],
                            ),
                          ),
                          if (slide.subtitle != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              slide.subtitle!,
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: slide.onPrimary,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C4CE5), // purple
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(slide.primaryLabel),
                              ),
                              if (slide.secondaryLabel != null && slide.onSecondary != null) ...[
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: slide.onSecondary,
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6C4CE5).withOpacity(0.9),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text(slide.secondaryLabel!),
                                ),
                              ],
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            // Added: top-right overlay buttons (SHOP NOW, LEARN MORE)
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (widget.slides.isNotEmpty && widget.slides[_currentIndex].onPrimary != null)
                        ? widget.slides[_currentIndex].onPrimary
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C4CE5), // purple
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 2,
                    ),
                    child: const Text('SHOP NOW', style: TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  // LEARN MORE (secondary)
                  OutlinedButton(
                    onPressed: (widget.slides.isNotEmpty && widget.slides[_currentIndex].onSecondary != null)
                        ? widget.slides[_currentIndex].onSecondary
                        : null,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C4CE5).withOpacity(0.9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('LEARN MORE', style: TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.slides.length, (i) {
                  final active = i == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active ? Colors.white : Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
