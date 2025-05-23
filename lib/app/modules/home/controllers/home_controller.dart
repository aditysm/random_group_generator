
import 'package:get/get.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';

class HomeController extends GetxController {
  var controller = Get.find<GenerateKelompokController>();
  @override
  void onInit() {
    controller.loadHistory();
    super.onInit();
  }
}
