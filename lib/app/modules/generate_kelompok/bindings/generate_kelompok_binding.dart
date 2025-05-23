import 'package:get/get.dart';

import '../controllers/generate_kelompok_controller.dart';

class GenerateKelompokBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateKelompokController>(
      () => GenerateKelompokController(),
    );
  }
}
