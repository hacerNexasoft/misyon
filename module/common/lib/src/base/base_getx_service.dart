import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class BaseGetxService extends GetxService {
  final logger = Get.find<Logger>();
  final dio = Get.find<Dio>();
}