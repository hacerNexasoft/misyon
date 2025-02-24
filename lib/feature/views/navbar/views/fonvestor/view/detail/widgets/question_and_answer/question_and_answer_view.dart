import 'package:common/common.dart';
import 'package:intl/intl.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/services/jwt_token_service.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'widgets/detail_message_widget.dart';
part 'widgets/manager_detail_message_widget.dart';

class QuestionAndAnswerView extends BaseGetView<DetailViewController> {
  const QuestionAndAnswerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        children: [
          _buildTitle,
          SizedBox(
            height: 20.h,
          ),
          _buildMessage,
          SizedBox(
            height: 20.h,
          ),
          _buildManagertextfind
        ],
      ),
    );
  }

  Widget get _buildTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ScaleFactorAutoSizeText(
              text: LocalizationKeys.qnaTextKey.tr,
              style: theme.primaryTextTheme.bodyLarge!.semibold.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      );

  Widget get _buildMessage => Padding(
        padding: EdgeInsets.all(10.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: List.generate(
              controller.selectedProjectCommentsList!.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 0.h),
                child: Column(
                  children: [
                    DetailMessageWidget(
                      user: controller.selectedProjectCommentsList![index].name,
                      message: controller.selectedProjectCommentsList![index].comment,
                      imageUrl: null,
                      messageDate: DateFormat('dd MM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              controller.selectedProjectCommentsList![index].commentDate * 1000)),
                    ),
                    Builder(
                      builder: (context) {
                        if (controller
                            .selectedProjectCommentsList![index].childComment.isNotEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: Column(
                                children: List.generate(
                              controller.selectedProjectCommentsList![index].childComment.length,
                              (index) {
                                return ManagerDetailMessageWidget(
                                  messageDate: DateFormat('dd MM yyyy').format(
                                      DateTime.fromMillisecondsSinceEpoch(controller
                                              .selectedProjectCommentsList![index]
                                              .childComment[index]
                                              .commentDate *
                                          1000)),
                                  user: controller
                                      .selectedProjectCommentsList![index].childComment[index].name,
                                  message: controller.selectedProjectCommentsList![index]
                                      .childComment[index].comment,
                                );
                              },
                            )),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _buildManagertextfind => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: AppColors.textFieldFillColor, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      textEditingController: controller.textController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.fillColor,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        side: BorderSide(color: AppColors.primaryColor, width: 1.w),
                      ),
                      onPressed: () {
                        final message = controller.textController.text;
                        if (message.isNotEmpty) {
                          final jwtTokenService = Get.find<JwtTokenService>();
                          if (jwtTokenService.jwtToken != null) {
                            // Mesaj gönderme işlemleri burada yapılacak
                            controller.textController.clear();
                          } else {
                            Get.toNamed(
                              AppRoutes.signInView,
                              //arguments: controller.selectedProjectDetails.value
                            );
                          }
                        }
                      },
                      child: const Text('Gönder'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
