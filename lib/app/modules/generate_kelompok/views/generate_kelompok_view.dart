// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:random_group_generator/all_material.dart';
import 'package:random_group_generator/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/generate_kelompok_controller.dart';

class GenerateKelompokView extends GetView<GenerateKelompokController> {
  const GenerateKelompokView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GenerateKelompokController());
    var scrollController = Get.put(ScrollController());
    return Scaffold(
      body: Center(
        heightFactor: 1,
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Appbar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Opacity(
                                  opacity: (controller.currentStep.value != 5)
                                      ? 1
                                      : 0,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: (controller.currentStep.value != 5)
                                        ? () {
                                            if (controller.currentStep.value !=
                                                5) {
                                              if (controller.currentStep.value >
                                                  1) {
                                                controller.setCurrentStep(
                                                    controller
                                                            .currentStep.value -
                                                        1);
                                              } else {
                                                Get.back();
                                                GenerateKelompokController()
                                                    .dispose();
                                              }
                                            } else {
                                              Get.back();
                                              GenerateKelompokController()
                                                  .dispose();
                                              controller.resetState();
                                            }
                                          }
                                        : null,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Batal",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: AllMaterial.fontExtraBold,
                                          color: AllMaterial.colorBluePrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(() => Text(
                                      _getTitle(controller.currentStep.value),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: AllMaterial.fontExtraBold,
                                        color: controller.isDarkMode.value
                                            ? AllMaterial.colorWhite
                                            : AllMaterial.colorBlackPrimary,
                                      ),
                                    )),
                                Obx(
                                  () => Opacity(
                                    opacity: (controller.currentStep.value == 5)
                                        ? 1
                                        : 0,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () async {
                                        String whatsappMessage =
                                            generateWhatsappMessage();
                                        SharePlus.instance.share(
                                            ShareParams(text: whatsappMessage));
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Share",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                AllMaterial.fontExtraBold,
                                            color: AllMaterial.colorBluePrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Stepper
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 5),
                              width: Get.width,
                              child: Obx(
                                () {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      StepperWidget(
                                        number: "1",
                                        titleText: "Pilih Kelas",
                                        isActive:
                                            controller.currentStep.value >= 1,
                                        isCompleted:
                                            controller.currentStep.value > 1,
                                      ),
                                      StepperWidget(
                                        number: "2",
                                        titleText: "Atur Tugas",
                                        isActive:
                                            controller.currentStep.value >= 2,
                                        isCompleted:
                                            controller.currentStep.value > 2,
                                      ),
                                      StepperWidget(
                                        number: "3",
                                        titleText: "Atur Jumlah",
                                        isActive:
                                            controller.currentStep.value >= 3,
                                        isCompleted:
                                            controller.currentStep.value > 3,
                                      ),
                                      StepperWidget(
                                        number: "4",
                                        titleText: "Pilih Ketua",
                                        isActive:
                                            controller.currentStep.value >= 4,
                                        isCompleted:
                                            controller.currentStep.value > 4,
                                      ),
                                      StepperWidget(
                                        number: "5",
                                        titleText: "Hasil",
                                        isActive:
                                            controller.currentStep.value >= 5,
                                        isCompleted:
                                            controller.currentStep.value > 5,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            // Text & Title
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Obx(
                                () => Text(
                                  _getSubTitle(controller.currentStep.value),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: AllMaterial.fontBlack,
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                _getTitleSub(controller.currentStep.value),
                                style: const TextStyle(
                                    // color: AllMaterial.colorGreyPrimary,
                                    ),
                              ),
                            ),

                            Obx(() =>
                                _getPageWidget(controller.currentStep.value)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      if (controller.currentStep.value == 3) {
                        return Container(
                          width: Get.width,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Banyak Siswa",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AllMaterial.colorGreyPrimary,
                                    ),
                                  ),
                                  Text(
                                    "${controller.anggotaKelas.length}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: AllMaterial.fontBold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  fixedSize: Size(Get.width, 48),
                                  backgroundColor: AllMaterial.colorBluePrimary,
                                ),
                                onPressed: () {
                                  if (controller.currentStep.value < 5) {
                                    controller.setCurrentStep(
                                      controller.currentStep.value + 1,
                                    );
                                    controller.jumlahSiswa();
                                    controller.setJumlahKelompok();
                                  }
                                },
                                child: const Text(
                                  "Lanjutkan",
                                  style: TextStyle(
                                    color: AllMaterial.colorWhite,
                                    fontWeight: AllMaterial.fontSemiBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (controller.currentStep.value == 4) {
                        return Container(
                          width: Get.width,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              ListTile(
                                title: RichText(
                                  text: TextSpan(
                                    text: "Tekan ",
                                    style: TextStyle(
                                      color: controller.isDarkMode.isTrue
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: AllMaterial.fontFamily,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: "Generate",
                                        style: TextStyle(
                                          fontWeight: AllMaterial.fontSemiBold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " untuk melewati tahap ini",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  fixedSize: Size(Get.width, 48),
                                  backgroundColor: AllMaterial.colorBluePrimary,
                                ),
                                onPressed: () {
                                  if (controller.currentStep.value < 5) {
                                    controller.setCurrentStep(
                                      controller.currentStep.value + 1,
                                    );
                                    controller.generateKelompok();
                                  }
                                },
                                child: const Text(
                                  "Generate",
                                  style: TextStyle(
                                    color: AllMaterial.colorWhite,
                                    fontWeight: AllMaterial.fontSemiBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (controller.currentStep.value == 5) {
                        return Container(
                          width: Get.width,
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              fixedSize: Size(Get.width, 48),
                              backgroundColor: AllMaterial.colorBluePrimary,
                            ),
                            onPressed: () {
                              Get.offAllNamed(Routes.HOME);
                            },
                            child: const Text(
                              "Selesai",
                              style: TextStyle(
                                color: AllMaterial.colorWhite,
                                fontWeight: AllMaterial.fontSemiBold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: Get.width,
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              fixedSize: Size(Get.width, 48),
                              backgroundColor: AllMaterial.colorBluePrimary,
                            ),
                            onPressed: () {
                              if (controller.currentStep.value < 5 &&
                                  controller.selectedKelas.value != "") {
                                controller.setCurrentStep(
                                  controller.currentStep.value + 1,
                                );
                                controller.setTitle();
                                controller.setTugas();
                              } else {
                                AllMaterial.messageScaffold(
                                    title: "Harap pilih kelas Anda!");
                              }
                            },
                            child: const Text(
                              "Lanjutkan",
                              style: TextStyle(
                                color: AllMaterial.colorWhite,
                                fontWeight: AllMaterial.fontSemiBold,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle(int step) {
    switch (step) {
      case 1:
        return "Pilih Kelas";
      case 2:
        return "Atur Tugas";
      case 3:
        return "Atur Jumlah";
      case 4:
        return "Pilih Ketua";
      case 5:
        return "Hasil";
      default:
        return "Gheral Ganteng";
    }
  }

  String _getSubTitle(int step) {
    switch (step) {
      case 1:
        return "Tentukan kelas Anda!";
      case 2:
        return "Sesuaikan dengan kebutuhan!";
      case 3:
        return "Atur jumlah kelompok Anda!";
      case 4:
        return "Tentukan ketua Anda!";
      case 5:
        return "Kelompok Anda!";
      default:
        return "Gheral Ganteng";
    }
  }

  String _getTitleSub(int step) {
    switch (step) {
      case 1:
        return "Pilih sesuai kebutuhan";
      case 2:
        return "Jangan lupa untuk mengatur tugas";
      case 3:
        return "Lihat dulu, berapa kelompok yang kamu inginkan";
      case 4:
        return "Pilih dulu, ketua kelompok yang kamu percayai!";
      case 5:
        return "Kurang puas? segala aksi sebelumnya tidak dapat diulang kembali, pilih Selesai kemudian ulangi";
      default:
        return "Gheral Ganteng";
    }
  }

  Widget _getPageWidget(int step) {
    Widget page;
    switch (step) {
      case 1:
        page = PilihKelas(controller: controller);
        break;
      case 2:
        page = ManajemenTugas(controller: controller);
        break;
      case 3:
        page = FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 20)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FilterPage(controller: controller);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
        break;
      case 4:
        page = GeneratePage(controller: controller);
        break;
      case 5:
        page = FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AllMaterial.messageScaffold(
                  title: "Proses generate telah selesai!",
                  adaButton: true,
                  tap: () {
                    AllMaterial.copyToClipboard(
                        generateWhatsappMessage(isToWa: false));
                  },
                  buttonTitle: "Salin",
                );
              });
              return ReviewPage(controller: controller);
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AllMaterial.colorBluePrimary,
                  ),
                ),
              );
            }
          },
        );
        break;
      default:
        page = const Center(
          child: Text("Gheral Ganteng"),
        );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: SizedBox(
        key: ValueKey<int>(step),
        child: page,
      ),
    );
  }

  String generateWhatsappMessage({bool isToWa = true}) {
    final title = controller.titleKelompok.value;
    final kelas = controller.selectedKelas.value;
    final deskripsiTugas = controller.tugasKelompok.value;
    final tanggalPresentasi = controller.presentasi.value;
    final tanggalDeadline = controller.deadline.value;
    final lampiranURL = controller.urlC.text;

    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    String message = isToWa ? "*$title $kelas*\n\n" : "$title $kelas\n\n";

    for (int i = 0; i < controller.kelompokList.length; i++) {
      final group = controller.kelompokList[i];
      message +=
          'Kelompok ${i + 1}${(controller.materiList.length > i) ? " - ${controller.materiList[i]}" : ""}\n';

      for (int j = 0; j < group.length; j++) {
        final siswa = group[j];
        message += "${j + 1}. ${siswa["nama"]}\n";
      }
      message += "\n";
    }

    if (deskripsiTugas.isNotEmpty) {
      message += "Deskripsi Tugas: $deskripsiTugas\n";
    }
    if (lampiranURL.isNotEmpty) {
      message += "Lampiran Tugas: $lampiranURL\n";
    }
    message += "\n";
    message +=
        "Tanggal Presentasi: ${DateFormat("dd MMM yyyy – HH:mm", 'id').format(tanggalPresentasi ?? DateTime.now().add(Duration(hours: 6)))}\n";
    message +=
        "Tenggat Akhir: ${DateFormat("dd MMM yyyy – HH:mm", 'id').format(tanggalDeadline ?? DateTime.now().add(Duration(days: 7)))}\n";
    message += "Dibuat Pada: $formattedDate\n";

    return message;
  }
}

class ReviewPage extends StatelessWidget {
  final GenerateKelompokController controller;

  const ReviewPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        // ignore: unused_local_variable
        final itemWidth =
            isMobile ? constraints.maxWidth : constraints.maxWidth / 2 - 20;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isMobile ? 18 : 25),
            Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    final message = generateWhatsappMessage(isToWa: false);
                    AllMaterial.copyToClipboard(message);
                  },
                  child: Row(
                    children: [
                      Text(
                        '${controller.titleKelompok.value} ${controller.selectedKelas.value}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 3),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'Salin kelompok',
                        onPressed: () {
                          final message =
                              generateWhatsappMessage(isToWa: false);
                          AllMaterial.copyToClipboard(message);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (controller.kelompokList.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  final int crossAxisCount = isMobile ? 1 : 3;
                  final double spacing = 14;
                  final double totalSpacing = spacing * (crossAxisCount - 1);
                  final double itemWidth =
                      (constraints.maxWidth - totalSpacing) / crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children:
                        List.generate(controller.kelompokList.length, (index) {
                      var group = controller.kelompokList[index];
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: itemWidth,
                          maxWidth: itemWidth,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffD4D6DD)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kelompok ${index + 1}${(controller.materiList.length > index) ? " - ${controller.materiList[index]}" : ""}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...group.asMap().entries.map<Widget>((entry) {
                                  int index = entry.key;
                                  var siswa = entry.value;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      '${index + 1}. ${siswa["nama"]}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            if (controller.kelompokList.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "Tidak ada kelompok yang dibentuk.",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            SizedBox(height: 15),
          ],
        );
      },
    );
  }

  String generateWhatsappMessage({bool isToWa = true}) {
    final title = controller.titleKelompok.value;
    final kelas = controller.selectedKelas.value;
    final deskripsiTugas = controller.tugasKelompok.value;
    final tanggalPresentasi = controller.presentasi.value;
    final tanggalDeadline = controller.deadline.value;
    final lampiranURL = controller.urlC.text;

    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    String message = isToWa ? "*$title $kelas*\n\n" : "$title $kelas\n\n";

    for (int i = 0; i < controller.kelompokList.length; i++) {
      final group = controller.kelompokList[i];
      message +=
          'Kelompok ${i + 1}${(controller.materiList.length > i) ? " - ${controller.materiList[i]}" : ""}\n';

      for (int j = 0; j < group.length; j++) {
        final siswa = group[j];
        message += "${j + 1}. ${siswa["nama"]}\n";
      }
      message += "\n";
    }

    if (deskripsiTugas.isNotEmpty) {
      message += "Deskripsi Tugas: $deskripsiTugas\n";
    }

    if (lampiranURL.isNotEmpty) {
      message += "Lampiran Tugas: $lampiranURL\n";
    }
    message += "\n";
    message +=
        "Tanggal Presentasi: ${DateFormat("dd MMM yyyy – HH:mm", 'id').format(tanggalPresentasi ?? DateTime.now().add(Duration(hours: 6)))}\n";
    message +=
        "Tenggat Akhir: ${DateFormat("dd MMM yyyy – HH:mm", 'id').format(tanggalDeadline ?? DateTime.now().add(Duration(days: 7)))}\n";
    message += "Dibuat Pada: $formattedDate\n";

    return message;
  }
}

class FilterPage extends StatefulWidget {
  final GenerateKelompokController controller;
  const FilterPage({super.key, required this.controller});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    controller.jumlahKelompok.text = controller.materiList.isEmpty
        ? 6.toString()
        : controller.materiList.length.toString();
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(16),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffD4D6DD),
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jumlah Kelompok",
              style: TextStyle(
                fontSize: 13,
                fontWeight: AllMaterial.fontBold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.jumlahKelompok,
              onTapOutside: (_) {
                controller.focusNodeJ.unfocus();
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                NumberRangeTextInputFormatter(min: 1, max: 15),
              ],
              focusNode: controller.focusNodeJ,
              cursorColor: AllMaterial.colorBluePrimary,
              decoration: const InputDecoration(
                hintText: "6",
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AllMaterial.colorGreySec,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: AllMaterial.colorBluePrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "*Jika jumlah materi per-kelompok & input kosong, nilai bawaan menjadi 6",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "*Jumlah anggota kelompok dibagi merata berdasarkan jumlah kelompok",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "*Saran pembagian kelompok (banyak siswa 36): \nJumlah Kelompok: 8 = 5 kelompok ada 5 orang & 3 kelompok ada 4 orang \nJumlah Kelompok: 6 = setiap kelompok ada 6 orang \nJumlah Kelompok: 4 = setiap kelompok ada 9 orang",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PilihKelas extends StatelessWidget {
  const PilihKelas({
    super.key,
    required this.controller,
  });

  final GenerateKelompokController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(16),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffD4D6DD),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Obx(() {
                final kelasList = controller.namaKelas;

                final kelasX = kelasList
                    .where((k) => RegExp(r'^X(?!I)').hasMatch(k))
                    .toList();
                final kelasXI = kelasList
                    .where((k) => RegExp(r'^XI(?!I)').hasMatch(k))
                    .toList();
                final kelasXII = kelasList
                    .where((k) => RegExp(r'^XII').hasMatch(k))
                    .toList();

                Widget buildGroup(String title, List<String> kelasGroup) {
                  if (kelasGroup.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: kelasGroup.map((kelas) {
                          return ChoiceChip(
                            label: Text(
                              kelas,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AllMaterial.colorWhite),
                            ),
                            checkmarkColor: AllMaterial.colorWhite,
                            elevation: 0,
                            side: const BorderSide(
                                width: 0, color: Colors.transparent),
                            selected: controller.selectedKelas.value == kelas,
                            onSelected: (_) =>
                                controller.toggleSelection(kelas),
                            selectedColor: AllMaterial.colorBluePrimary,
                            backgroundColor: controller.isDarkMode.value
                                ? AllMaterial.colorGreyPrimary.withOpacity(0.4)
                                : AllMaterial.colorBlueSec,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildGroup("Kelas X", kelasX),
                    buildGroup("Kelas XI", kelasXI),
                    buildGroup("Kelas XII", kelasXII),
                  ],
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class NumberRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumberRangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int value = int.parse(newValue.text);

    if (value < min) {
      return const TextEditingValue().copyWith(text: min.toString());
    } else if (value > max) {
      return const TextEditingValue().copyWith(text: max.toString());
    }

    return newValue;
  }
}

class StepperWidget extends StatelessWidget {
  final String number;
  final String titleText;
  final bool isActive;
  final bool isCompleted;

  const StepperWidget({
    super.key,
    required this.titleText,
    required this.number,
    this.isActive = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GenerateKelompokController());
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isActive
              ? AllMaterial.colorBluePrimary
              : AllMaterial.colorGreyPattern,
          child: isCompleted
              ? const Icon(Icons.check, color: AllMaterial.colorWhite)
              : Text(
                  number,
                  style: TextStyle(
                    color: isActive
                        ? AllMaterial.colorWhite
                        : AllMaterial.colorGreyPrimary,
                    fontSize: 14,
                    fontWeight: AllMaterial.fontSemiBold,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        Text(
          titleText,
          style: TextStyle(
            color: isActive
                ? controller.isDarkMode.value
                    ? AllMaterial.colorWhite
                    : AllMaterial.colorBlackPrimary
                : controller.isDarkMode.value
                    ? AllMaterial.colorGreyPrimary
                    : Colors.grey,
            fontSize: 14,
            fontWeight: AllMaterial.fontBold,
          ),
        ),
      ],
    );
  }
}

class ManajemenTugas extends StatelessWidget {
  final GenerateKelompokController controller;
  const ManajemenTugas({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.only(top: 14, bottom: 14),
        padding: const EdgeInsets.all(16),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xffD4D6DD),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mata Pelajaran
            const Text("Mata Pelajaran",
                style:
                    TextStyle(fontSize: 13, fontWeight: AllMaterial.fontBold)),
            const SizedBox(height: 8),
            TextField(
              controller: controller.titleC,
              focusNode: controller.focusNodeC,
              cursorColor: AllMaterial.colorBluePrimary,
              onTapOutside: (_) => controller.focusNodeC.unfocus(),
              decoration: const InputDecoration(
                labelText: "PPKN",
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AllMaterial.colorGreySec),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AllMaterial.colorBluePrimary),
                ),
              ),
            ),

            const SizedBox(height: 25),
            // Poin Kompetensi
            const Text("Poin Kompetensi",
                style:
                    TextStyle(fontSize: 13, fontWeight: AllMaterial.fontBold)),
            const SizedBox(height: 8),
            TextField(
              controller: controller.poinC,
              focusNode: controller.focusNodeP,
              onTapOutside: (_) => controller.focusNodeP.unfocus(),
              cursorColor: AllMaterial.colorBluePrimary,
              decoration: const InputDecoration(
                labelText: "KD 3.2 atau BAB 3",
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AllMaterial.colorGreySec),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AllMaterial.colorBluePrimary),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Deskripsi Tugas
            const Text("Deskripsi Tugas",
                style:
                    TextStyle(fontSize: 13, fontWeight: AllMaterial.fontBold)),
            const SizedBox(height: 8),
            TextField(
              controller: controller.tugasC,
              focusNode: controller.focusNodeT,
              onTapOutside: (_) => controller.focusNodeT.unfocus(),
              maxLines: 3,
              cursorColor: AllMaterial.colorBluePrimary,
              decoration: const InputDecoration(
                labelText: "Membuat Projek",
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AllMaterial.colorGreySec),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AllMaterial.colorBluePrimary),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Pengaturan Role
            Obx(
              () => ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "Pengaturan Role",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: AllMaterial.fontBold,
                  ),
                ),
                trailing: Switch(
                  value: controller.isRole.value,
                  onChanged: (val) {
                    controller.isRole.value = val;
                    controller.isRoleAuto.value = true;
                  },
                  activeColor: AllMaterial.colorBluePrimary.withOpacity(0.4),
                  thumbColor: const WidgetStatePropertyAll(Colors.white),
                ),
                onTap: () {
                  controller.isRole.toggle();
                  controller.isRoleAuto.value = true;
                },
              ),
            ),

            Obx(
              () => SizedBox(
                height: controller.isRole.isTrue ? 8 : 0,
              ),
            ),
            Obx(
              () => controller.isRole.isTrue
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Buat Role Otomatis untuk setiap anggota?",
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Switch(
                              value: controller.isRoleAuto.value,
                              onChanged: (val) =>
                                  controller.isRoleAuto.value = val,
                              activeColor:
                                  AllMaterial.colorBluePrimary.withOpacity(0.4),
                              thumbColor:
                                  const WidgetStatePropertyAll(Colors.white),
                            ),
                            onTap: () {
                              controller.isRoleAuto.toggle();
                            },
                          ),
                        ),
                        Obx(
                          () => controller.isRoleAuto.isTrue
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Role penting yang akan dibuat:\n"
                                      "• Ketua\n"
                                      "• Penulis\n"
                                      "• Penyaji\n"
                                      "• Peneliti\n"
                                      "• (Sisanya sebagai Anggota)",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),

            Obx(
              () => SizedBox(
                height:
                    controller.isRole.isTrue && controller.isRoleAuto.isFalse
                        ? 16
                        : 0,
              ),
            ),
            Obx(
              () => controller.isRole.isTrue && controller.isRoleAuto.isFalse
                  ? RoleChipInput(controller: controller)
                  : SizedBox.shrink(),
            ),
            const SizedBox(height: 20),

            // Deadline Tugas
            const Text(
              "Deadline Tugas",
              style: TextStyle(fontSize: 13, fontWeight: AllMaterial.fontBold),
            ),
            const SizedBox(height: 8),
            Obx(() => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(controller.deadline.value != null
                      ? DateFormat("dd MMM yyyy – HH:mm", 'id')
                          .format(controller.deadline.value!)
                      : "Pilih Deadline"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        // ignore: use_build_context_synchronously
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        controller.deadline.value = DateTime(date.year,
                            date.month, date.day, time.hour, time.minute);
                      }
                    }
                  },
                )),

            const SizedBox(height: 20),

            // Tanggal Presentasi
            const Text("Tanggal Presentasi",
                style:
                    TextStyle(fontSize: 13, fontWeight: AllMaterial.fontBold)),
            const SizedBox(height: 8),
            Obx(
              () => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(controller.presentasi.value != null
                    ? DateFormat("dd MMM yyyy – HH:mm", 'id')
                        .format(controller.presentasi.value!)
                    : "Pilih Tanggal"),
                trailing: const Icon(Icons.calendar_month),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      // ignore: use_build_context_synchronously
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      controller.presentasi.value = DateTime(date.year,
                          date.month, date.day, time.hour, time.minute);
                    }
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            // URL Lampiran
            const Text("Lampiran URL",
                style:
                    TextStyle(fontSize: 13, fontWeight: AllMaterial.fontBold)),
            const SizedBox(height: 8),
            TextField(
              controller: controller.urlC,
              focusNode: controller.focusNodeU,
              cursorColor: AllMaterial.colorBluePrimary,
              onTapOutside: (_) => controller.focusNodeU.unfocus(),
              decoration: const InputDecoration(
                labelText: "https://contoh.com/tugas",
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AllMaterial.colorGreySec),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AllMaterial.colorBluePrimary),
                ),
              ),
            ),

            const SizedBox(height: 25),

            MateriChipInput(controller: controller),
          ],
        ),
      ),
    );
  }
}

class MateriChipInput extends StatelessWidget {
  final GenerateKelompokController controller;

  const MateriChipInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Materi per Kelompok",
          style: TextStyle(
            fontSize: 13,
            fontWeight: AllMaterial.fontBold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.materiInputC,
          focusNode: controller.focusNodeM,
          cursorColor: AllMaterial.colorBluePrimary,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              controller.addMateri(value.trim());
              controller.materiInputC.clear();
              controller.focusNodeM.requestFocus();
            }
          },
          onTapOutside: (_) => controller.focusNodeM.unfocus(),
          decoration: InputDecoration(
            labelText: "Ketik materi lalu tekan enter",
            alignLabelWithHint: true,
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final text = controller.materiInputC.text.trim();
                if (text.isNotEmpty) {
                  controller.addMateri(text.trim());
                  controller.materiInputC.clear();
                  controller.focusNodeM.requestFocus();
                }
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllMaterial.colorGreySec),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: AllMaterial.colorBluePrimary),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.materiList
                .map((item) => Chip(
                      backgroundColor: Get.isDarkMode
                          ? Theme.of(context).chipTheme.backgroundColor
                          : AllMaterial.colorWhite,
                      label: Text(item),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () => controller.removeMateri(item),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class RoleChipInput extends StatelessWidget {
  final GenerateKelompokController controller;

  const RoleChipInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tambahkan Role Secara Manual",
          style: TextStyle(
            fontSize: 13,
            fontWeight: AllMaterial.fontBold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.roleInputC,
          focusNode: controller.focusNodeR,
          cursorColor: AllMaterial.colorBluePrimary,
          // textInputAction: TextInputAction.done,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              controller.addRole(value.trim());
              controller.roleInputC.clear();
              controller.focusNodeR.requestFocus();
            }
          },
          onTapOutside: (_) => controller.focusNodeR.unfocus(),
          decoration: InputDecoration(
            labelText: "Ketik role lalu tekan enter",
            alignLabelWithHint: true,
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final text = controller.roleInputC.text.trim();
                if (text.isNotEmpty) {
                  controller.addRole(text.trim());
                  controller.roleInputC.clear();
                  controller.focusNodeR.requestFocus();
                }
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AllMaterial.colorGreySec),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: AllMaterial.colorBluePrimary),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.roleList
                .map((item) => Chip(
                      backgroundColor: Get.isDarkMode
                          ? Theme.of(context).chipTheme.backgroundColor
                          : AllMaterial.colorWhite,
                      label: Text(item),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () => controller.removeRole(item),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class GeneratePage extends StatelessWidget {
  final GenerateKelompokController controller;
  const GeneratePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.all(16),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xffD4D6DD),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tentukan Ketua (${controller.jumlahKelompokSet} ketua)",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: AllMaterial.fontBold,
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(builder: (context, constraints) {
              return Obx(
                () {
                  final anggota = controller.anggotaKelas.cast<String>();

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: anggota.map<Widget>((nama) {
                      return SizedBox(
                        child: ChoiceChip(
                          checkmarkColor: AllMaterial.colorWhite,
                          label: Text(
                            nama,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AllMaterial.colorWhite,
                            ),
                          ),
                          elevation: 0,
                          side: const BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                          selected: controller.selectedKetua.contains(nama),
                          onSelected: (bool selected) {
                            controller.pilihKetua(nama);
                          },
                          selectedColor: AllMaterial.colorBluePrimary,
                          backgroundColor: controller.isDarkMode.value
                              ? AllMaterial.colorGreyPrimary.withOpacity(0.4)
                              : AllMaterial.colorBlueSec,
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
