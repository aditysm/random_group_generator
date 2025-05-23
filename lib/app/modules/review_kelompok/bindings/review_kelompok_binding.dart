import 'package:get/get.dart';

import '../controllers/review_kelompok_controller.dart';

class ReviewKelompokBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewKelompokController>(
      () => ReviewKelompokController(),
    );
  }
}
