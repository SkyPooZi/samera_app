import 'package:flutter/material.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';

class GalleryScreen extends StatelessWidget {
  final DestinationEntity destination;

  const GalleryScreen({super.key, required this.destination});

  void _openFullscreenGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullscreenGalleryViewer(
          gallery: destination.gallery,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsResources.colorsWhite,
      appBar: AppBar(
        backgroundColor: ColorsResources.colorsWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: ColorsResources.colorsPrimary,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          destination.name,
          style: tsBodyLargeSemiBold(ColorsResources.colorsBlue),
        ),
        centerTitle: true,
      ),
      body: destination.gallery.isEmpty
          ? Center(
              child: Text(
                'Belum ada foto di galeri ini.',
                style: tsBodyMediumRegular(ColorsResources.colorsGrey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: destination.gallery.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _openFullscreenGallery(context, index),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        destination.gallery[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class FullscreenGalleryViewer extends StatefulWidget {
  final List<String> gallery;
  final int initialIndex;

  const FullscreenGalleryViewer({
    super.key,
    required this.gallery,
    required this.initialIndex,
  });

  @override
  State<FullscreenGalleryViewer> createState() => _FullscreenGalleryViewerState();
}

class _FullscreenGalleryViewerState extends State<FullscreenGalleryViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Swipeable Pager with Pinch to Zoom
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.gallery.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.network(
                      widget.gallery[index],
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[900],
                        width: double.infinity,
                        height: 250,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Top Action Controls
          Positioned(
            top: MediaQuery.paddingOf(context).top + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_currentIndex + 1} / ${widget.gallery.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 40), // spacer for balance
              ],
            ),
          ),
        ],
      ),
    );
  }
}
