import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

abstract class AllMaterial {
  // Copy
  static void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    messageScaffold(title: "Berhasil disalin ke papan klip!");
  }

  // Message
  static void messageScaffold({
    required String title,
    bool adaButton = false,
    void Function()? tap,
    String? buttonTitle,
  }) {
    if (Get.context != null) {
      final estimatedSeconds = (title.length / 12).ceil();
      final duration = Duration(seconds: estimatedSeconds.clamp(2, 10));

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 60,
            left: 100,
            right: 100,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: duration,
          content: Align(
            alignment: Alignment.center,
            child: IntrinsicWidth(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[900]?.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (adaButton) ...[
                      const SizedBox(width: 12),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AllMaterial.colorBluePrimary,
                        ),
                        onPressed: tap ?? () {},
                        child: Text(buttonTitle ?? "Lihat"),
                      ),
                    ],
                    if (!adaButton) ...[
                      const SizedBox(width: 12),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => ScaffoldMessenger.of(Get.context!)
                              .hideCurrentSnackBar(),
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  // Validasi
  static void showDialogValidasi({
    required VoidCallback? onConfirm,
    required String? title,
    required String? subtitle,
    required VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: AllMaterial.fontBold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  "$subtitle",
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onCancel,
                      child: Text(
                        "BATAL",
                        style: TextStyle(
                          color: AllMaterial.colorBluePrimary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: onConfirm,
                      child: Text(
                        "LANJUT",
                        style: TextStyle(
                          color: AllMaterial.colorBluePrimary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Font Weight
  static const fontFamily = "Inter";
  static const fontBlack = FontWeight.w900;
  static const fontExtraBold = FontWeight.w800;
  static const fontBold = FontWeight.w700;
  static const fontSemiBold = FontWeight.w600;
  static const fontMedium = FontWeight.w500;
  static const fontRegular = FontWeight.w400;

  // Color
  static const colorBlackPrimary = Color(0xff1F2024);
  static const colorGreyPrimary = Color(0xff71727A);
  static const colorGreySec = Color(0xffD4D6DD);
  static const colorGreyPattern = Color(0xffE8E9F1);
  static const colorWhiteBlue = Color(0xffEAF2FF);
  static const colorWhite = Color(0xffF8F9FE);
  static const colorBlueSec = Color(0xffB4DBFF);
  static const colorBluePrimary = Color(0xff006FFD);

  // Storage
  static var box = GetStorage();

  // Windows Options
  static WindowOptions windowOptions = WindowOptions(
    title: 'Random Group Generator',
    minimumSize: Size(600, 800),
    center: true,
  );
}
