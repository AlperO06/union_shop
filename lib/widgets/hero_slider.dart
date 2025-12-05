// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // added import
import 'package:cached_network_image/cached_network_image.dart';

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
    this.primaryLabel = 'FIND OUT MORE',
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
    this.autoPlayInterval = const Duration(seconds: 6),
    this.autoPlay = true, required bool isMobile, required double heroTitleSize, required double heroSubtitleSize, required double heroTop,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HeroSliderState createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  late final PageController _controller;
  late int _currentIndex;
  Timer? _timer;
  bool _userInteracting = false;
  // tracks whether autoplay is explicitly paused (separate from transient user interaction)
  bool _autoplayPaused = false;

  // programmatic controls if needed elsewhere
  void pauseAutoplay() {
    _autoplayPaused = true;
    _stopAutoPlay();
  }

  void resumeAutoplay() {
    _autoplayPaused = false;
    if (widget.autoPlay && widget.slides.length > 1) _startAutoPlay();
  }

  // toggles between play and pause states for autoplay
  void togglePlayPause() {
    if (_timer != null) {
      // currently playing -> pause
      setState(() {
        _autoplayPaused = true;
      });
      _stopAutoPlay();
    } else {
      // currently paused -> resume
      setState(() {
        _autoplayPaused = false;
      });
      if (widget.autoPlay && widget.slides.length > 1) _startAutoPlay();
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: 0);
    if (widget.autoPlay && widget.slides.length > 1) {
      _startAutoPlay();
    }
  }

  @override
  void didUpdateWidget(covariant HeroSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    // restart/stop autoplay when slides or autoplay flag change
    final slidesChanged = oldWidget.slides.length != widget.slides.length;
    final autoplayChanged = oldWidget.autoPlay != widget.autoPlay;
    if (slidesChanged || autoplayChanged) {
      _stopAutoPlay();
      // clamp current index to new range
      if (widget.slides.isNotEmpty) {
        _currentIndex = _currentIndex.clamp(0, widget.slides.length - 1);
        _controller.jumpToPage(_currentIndex);
      } else {
        _currentIndex = 0;
      }
      if (widget.autoPlay && widget.slides.length > 1) {
        _startAutoPlay();
      }
    }
  }

  void _startAutoPlay() {
    // avoid multiple timers
    if (_timer != null) return;
    if (!widget.autoPlay || widget.slides.length <= 1) return;
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (t) {
      if (!mounted) return;
      if (_userInteracting) return;
      if (_autoplayPaused) return;
      if (widget.slides.isEmpty) return;
      final next = (_currentIndex + 1) % widget.slides.length;
      // animate only if still mounted
      if (!mounted) return;
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

  // add helper to open Domino's (tries external browser, falls back to internal route)
  Future<void> _openDominos() async {
    final uri = Uri.parse('https://www.dominos.com');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}
    // fallback: navigate to an internal route if desired
    if (mounted) Navigator.pushNamed(context, '/dominos');
  }

  @override
  Widget build(BuildContext context) {
    // Create a local copy of slides and remove the 5th slide (index 4) if present
    final displayedSlides = List<HeroSlide>.from(widget.slides);
    if (displayedSlides.length >= 5) {
      displayedSlides.removeAt(4);
    }

    // Ensure current index is valid for the displayed slides; jump if necessary
    if (_currentIndex >= displayedSlides.length && displayedSlides.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _currentIndex = _currentIndex.clamp(0, displayedSlides.length - 1);
        _controller.jumpToPage(_currentIndex);
      });
    }

    if (displayedSlides.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: Container(
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: const Text('No slides available'),
        ),
      );
    }

    // Make height responsive: on small screens constrain to a fraction of screen height
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final maxMobileHeight = screenSize.height * 0.45;
    final effectiveHeight = isMobile ? (widget.height < maxMobileHeight ? widget.height : maxMobileHeight) : widget.height;

    return SizedBox(
      height: effectiveHeight,
      // Replace GestureDetector with NotificationListener so PageView remains swipeable
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification && notification.dragDetails != null) {
            // user started dragging
            _userInteracting = true;
            // mark autoplay as paused during user interaction
            _autoplayPaused = true;
            _stopAutoPlay();
          } else if (notification is ScrollEndNotification) {
            // scrolling ended
            _userInteracting = false;
            // resume autoplay after interaction
            _autoplayPaused = false;
            if (widget.autoPlay && widget.slides.length > 1) _startAutoPlay();
          }
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: displayedSlides.length,
              // Allow swiping only when more than one slide exists
              physics: displayedSlides.length > 1 ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final slide = displayedSlides[index];
                // Ensure the second slide (index 1) uses the required label
                // use VERIFY AND SAVE + redirect for the fourth slide (index == 3)
                final primaryButtonLabel = (index == 3)
                    ? 'VERIFY AND SAVE'
                    : (index == 1 ? 'FIND OUT MORE' : slide.primaryLabel);
                final VoidCallback primaryOnPressed = (index == 3)
                    ? () => _openDominos()
                    : slide.onPrimary ?? () => Navigator.pushNamed(context, '/print-shack');

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: slide.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
                      ),
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
                                onPressed: primaryOnPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C4CE5), // purple
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(primaryButtonLabel),
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
                    onPressed: () => Navigator.pushNamed(context, '/sale'),
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
                    onPressed: () => Navigator.pushNamed(context, '/about'),
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
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // dot indicators
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(displayedSlides.length, (i) {
                        final active = i == _currentIndex;
                        return GestureDetector(
                          onTap: () {
                            // animate to tapped page and update state for immediate feedback
                            _controller.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              _currentIndex = i;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: active ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: active ? Colors.white : Colors.white54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 10),
                    // play/pause button placed beside indicators
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: togglePlayPause,
                        icon: Icon(
                          (_timer != null && !_autoplayPaused) ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                        tooltip: (_timer != null && !_autoplayPaused) ? 'Pause autoplay' : 'Play autoplay',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Prev / Next arrow buttons
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    tooltip: 'Previous',
                    icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                    onPressed: () async {
                      if (displayedSlides.isEmpty) return;
                      final prev = (_currentIndex - 1 + displayedSlides.length) % displayedSlides.length;
                      // pause autoplay while animating
                      final wasAutoplay = widget.autoPlay && _timer != null;
                      _stopAutoPlay();
                      _userInteracting = true;
                      await _controller.animateToPage(prev, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      setState(() {
                        _currentIndex = prev;
                      });
                      _userInteracting = false;
                      if (wasAutoplay) _startAutoPlay();
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    tooltip: 'Next',
                    icon: const Icon(Icons.chevron_right, color: Colors.white, size: 28),
                    onPressed: () async {
                      if (displayedSlides.isEmpty) return;
                      final next = (_currentIndex + 1) % displayedSlides.length;
                      // pause autoplay while animating
                      final wasAutoplay = widget.autoPlay && _timer != null;
                      _stopAutoPlay();
                      _userInteracting = true;
                      await _controller.animateToPage(next, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                      setState(() {
                        _currentIndex = next;
                      });
                      _userInteracting = false;
                      if (wasAutoplay) _startAutoPlay();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
