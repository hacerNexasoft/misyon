
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget extends BaseStatelessWidget {
  final Color? indicatorColor;
  const LoadingWidget({super.key, this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: indicatorColor ?? AppColors.white,
      ),
    );
  }
}