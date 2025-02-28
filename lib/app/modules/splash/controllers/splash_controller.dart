import 'package:get/get.dart';
import 'package:mypokedex/app/routes/app_pages.dart';

import '../../home/controllers/home_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    var homeController = Get.find<HomeController>();
    homeController.loadInitialData();

    // when all data is loaded, navigate to home page
    homeController.isFirstInitialCall.listen((_) {
      Get.offNamed(Routes.HOME);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
