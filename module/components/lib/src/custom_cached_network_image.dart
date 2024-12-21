
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final BoxFit? fit;
  final double? width;
  final double? height;
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
    this.placeholder,
    this.errorWidget,
    this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: CacheManager(
        Config(
          imageUrl,
          stalePeriod: const Duration(days: 1),
        ),
      ),
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fit: fit,
      width: width,
      height: height,
    );
  }
}