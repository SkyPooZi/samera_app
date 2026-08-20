import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:samera_app/core/styles/colors/colors.dart';
import 'package:samera_app/core/styles/typography/text_styles.dart';
import 'package:samera_app/features/home/domain/entities/destination_entity.dart';

class Panorama360Screen extends StatefulWidget {
  final DestinationEntity destination;

  const Panorama360Screen({super.key, required this.destination});

  @override
  State<Panorama360Screen> createState() => _Panorama360ScreenState();
}

class _Panorama360ScreenState extends State<Panorama360Screen> {
  bool _hasError = false;

  String _getNormalizedAssetPath(String assetPath) {
    final parts = assetPath.split('/');
    if (parts.isEmpty) return assetPath;
    final fileName = parts.last;
    final normalizedFileName = fileName.replaceAll(' ', '-').toLowerCase();
    parts[parts.length - 1] = normalizedFileName;
    return parts.join('/');
  }

  @override
  Widget build(BuildContext context) {
    final panorama = widget.destination.panorama360;
    final bool hasValidPanorama = panorama != null &&
        panorama.enabled &&
        panorama.asset != null;

    final String? assetPath = hasValidPanorama ? _getNormalizedAssetPath(panorama.asset!) : null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 360 Panorama Viewer or Fallback
          Positioned.fill(
            child: (!hasValidPanorama || _hasError || assetPath == null)
                ? Container(
                    color: ColorsResources.colorsWhite,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: ColorsResources.colorsGrey,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Foto 360° belum tersedia',
                            style: tsBodyLargeMedium(ColorsResources.colorsGrey),
                          ),
                        ],
                      ),
                    ),
                  )
                : PanoramaViewer(
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _hasError = true;
                            });
                          }
                        });
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
          ),

          // Header Overlay
          Positioned(
            top: MediaQuery.paddingOf(context).top + 16,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorsResources.colorsPrimary,
                    radius: 20,
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.destination.name,
                      style: tsBodyMediumSemiBold(Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
