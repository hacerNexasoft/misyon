import 'package:widgets/components.dart';
import 'package:common/common.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ProjectCustomCachedNetworkImageComp extends BaseStatelessWidget {
  final String? imageUrl;
  final double? size;
  final bool? isCircular;
  final BoxFit? fit;

  const ProjectCustomCachedNetworkImageComp({
    super.key,
    required this.imageUrl,
    this.size,
    this.isCircular = true,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return isCircular!
        ? ClipOval(
            child: _buildImage(),
          )
        : _buildImage();
  }

  Widget _buildImage() {
    return SizedBox(
      width: size ?? Get.height * 0.01,
      height: size ?? Get.height * 0.01,
      child: CustomCachedNetworkImage(
        imageUrl: imageUrl ?? '',
        imageBuilder: (context, imageProvider) => Container(
          width: size ?? Get.height * 0.01,
          height: size ?? Get.height * 0.01,
          decoration: BoxDecoration(
            borderRadius: isCircular! ? null : BorderRadius.circular(0),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.fitHeight,
            ),
          ),
        ),
        placeholder: (context, url) => SkeletonAnimation(
          child: SizedBox(
            width: size ?? Get.height * 0.01,
            height: size ?? Get.height * 0.01,
          ),
        ),
        errorWidget: (context, url, error) => LayoutBuilder(
          builder: (context, constraint) {
            return Icon(
              Icons.error_outline,
              size: constraint.biggest.height,
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
