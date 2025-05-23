import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:random_group_generator/all_material.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';
import 'package:random_group_generator/app/modules/home/views/home_view.dart';
import 'package:random_group_generator/loading_splash_view.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    var controller = Get.put(GenerateKelompokController());
    controller.loadHistory();
  });
  await initializeDateFormatting('id', null);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    windowManager.waitUntilReadyToShow(AllMaterial.windowOptions, () async {
      await windowManager.maximize();
    });
  }
  await GetStorage.init();
  var isDarkMode = AllMaterial.box.read("isDarkMode") ?? false;
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AllMaterial.colorWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AllMaterial.colorBluePrimary,
          brightness: Brightness.light,
          primary: AllMaterial.colorBluePrimary,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
          onSecondary: Colors.white,
          surface: AllMaterial.colorWhite,
          onSurface: Colors.black,
          error: Colors.grey,
          onError: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AllMaterial.colorWhite,
          surfaceTintColor: Colors.transparent,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(AllMaterial.colorWhite),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AllMaterial.colorBluePrimary,
          brightness: Brightness.dark,
          primary: AllMaterial.colorBluePrimary,
          onPrimary: Colors.black,
          secondary: Colors.lightBlueAccent,
          onSecondary: Colors.black,
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white,
          error: Colors.grey,
          onError: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          surfaceTintColor: Colors.transparent,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF1E1E1E)),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ),
      themeMode: isDarkMode == null
          ? ThemeMode.system
          : isDarkMode == true
              ? ThemeMode.dark
              : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "Random Group Generator",
      home: LoadingSplashView(
        title: 'Tunggu sebentar!',
        animationAsset: 'assets/images/loading.json',
        onCompleted: () {
          Get.offAll(
            () => HomeView(),
          );
        },
      ),
      getPages: AppPages.routes,
    ),
  );
}
