// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/all_material.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/views/generate_kelompok_view.dart';
import 'package:random_group_generator/app/modules/home/controllers/home_controller.dart';
import 'package:random_group_generator/app/modules/review_kelompok/views/review_kelompok_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final generateController = Get.put(GenerateKelompokController());
    final isDark = generateController.isDarkMode;
    final RxSet<String> selectedIds = <String>{}.obs;
    return GestureDetector(
      onTap: () {
        selectedIds.clear();
        generateController.selectedKelasFilter.value = '';
        generateController.searchQuery.value = '';
      },
      child: Scaffold(
        body: Center(
          heightFactor: 1,
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  final isSemiWide = constraints.maxWidth > 815;
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: isWide ? 50 : 30,
                      horizontal: isWide ? 48 : 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bagi Kelompok Tanpa Ribet!",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Biarkan sistem membagi kelompok dengan adil dan cepat.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isWide)
                              Row(
                                children: [
                                  Obx(
                                    () => TextButton(
                                      style: TextButton.styleFrom(
                                        alignment: Alignment.center,
                                        elevation: 0,
                                        backgroundColor: isDark.value
                                            ? AllMaterial.colorBlackPrimary
                                            : AllMaterial.colorWhiteBlue,
                                        padding: EdgeInsets.all(15),
                                      ),
                                      onPressed: generateController.toggleTheme,
                                      child: Row(
                                        children: [
                                          Obx(() {
                                            return AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              transitionBuilder: (Widget child,
                                                  Animation<double> animation) {
                                                return RotationTransition(
                                                  turns: Tween<double>(
                                                    begin: 0.75,
                                                    end: 1,
                                                  ).animate(animation),
                                                  child: FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                isDark.value
                                                    ? Icons.light_mode
                                                    : Icons.dark_mode,
                                                key: ValueKey<bool>(
                                                    isDark.value),
                                                color: isDark.value
                                                    ? Colors.white
                                                    : Colors.black,
                                                size: 24,
                                              ),
                                            );
                                          }),
                                          isSemiWide
                                              ? SizedBox(width: 5)
                                              : SizedBox.shrink(),
                                          isSemiWide
                                              ? Text(
                                                  isDark.value
                                                      ? "Light Mode"
                                                      : "Dark Mode",
                                                  style: TextStyle(
                                                    color: isDark.value
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      generateController.resetState();
                                      Get.to(
                                          () => const GenerateKelompokView());
                                    },
                                    style: TextButton.styleFrom(
                                      alignment: Alignment.center,
                                      elevation: 0,
                                      backgroundColor:
                                          AllMaterial.colorBluePrimary,
                                      padding: EdgeInsets.all(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          key: ValueKey<int>(DateTime.now()
                                              .millisecondsSinceEpoch),
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        isSemiWide
                                            ? SizedBox(width: 5)
                                            : SizedBox.shrink(),
                                        isSemiWide
                                            ? const Text(
                                                "Generate Kelompok",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),

                        // HISTORI
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: HistorySection(
                            selectedIds: selectedIds,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            if (isWide) return const SizedBox.shrink();

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => FloatingActionButton(
                      tooltip: "Ubah Tema",
                      heroTag: "darkModeToggle",
                      elevation: 2,
                      backgroundColor: isDark.value
                          ? AllMaterial.colorBlackPrimary
                          : AllMaterial.colorWhiteBlue,
                      onPressed: generateController.toggleTheme,
                      child: Obx(() {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return RotationTransition(
                              turns: Tween<double>(
                                begin: 0.75,
                                end: 1,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            isDark.value ? Icons.light_mode : Icons.dark_mode,
                            key: ValueKey<bool>(isDark.value),
                            color: isDark.value ? Colors.white : Colors.black,
                            size: 24,
                          ),
                        );
                      }),
                    )),
                const SizedBox(height: 16),
                FloatingActionButton(
                  tooltip: "Generate Kelompok",
                  heroTag: "generateKelompok",
                  backgroundColor: AllMaterial.colorBluePrimary,
                  onPressed: () {
                    generateController.resetState();
                    Get.to(() => const GenerateKelompokView());
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(height: 25),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HistorySection extends StatelessWidget {
  final generateController = Get.find<GenerateKelompokController>();
  final RxSet<String> selectedIds;
  HistorySection({super.key, required this.selectedIds});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var isSelecting = selectedIds.isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Histori :",
                  style: TextStyle(fontWeight: AllMaterial.fontBlack),
                ),
                if (!isSelecting)
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      if (generateController.histori.isEmpty) {
                        AllMaterial.messageScaffold(
                            title: "Tidak ada data yang bisa dihapus!");
                      } else {
                        AllMaterial.showDialogValidasi(
                          title: "Hapus Semua Histori",
                          subtitle: "Semua data akan dihapus. Lanjutkan?",
                          onConfirm: () {
                            generateController.histori.clear();
                            generateController.histori.refresh();
                            AllMaterial.messageScaffold(
                                title: "Data berhasil dihapus!");
                            Get.back();
                          },
                          onCancel: () {
                            Get.back();
                          },
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "Hapus Semua",
                            style: TextStyle(
                              fontWeight: AllMaterial.fontBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isSelecting)
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      AllMaterial.showDialogValidasi(
                        title: "Hapus Histori Terpilih",
                        subtitle: "Data terpilih akan dihapus. Lanjutkan?",
                        onConfirm: () {
                          generateController
                              .removeHistoryByIds(selectedIds.toList());
                          selectedIds.clear();
                          AllMaterial.messageScaffold(
                              title: "Data berhasil dihapus!");
                          Get.back();
                        },
                        onCancel: () {
                          Get.back();
                          selectedIds.clear();
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "Hapus Terpilih",
                            style: TextStyle(
                              fontWeight: AllMaterial.fontBold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            Obx(() {
              final isDark = generateController.isDarkMode;

              generateController.searchC.text =
                  generateController.searchQuery.isEmpty
                      ? ""
                      : generateController.searchQuery.value;
              final histori = generateController.histori;

              final query = generateController.searchQuery.value.toLowerCase();
              final selectedKelas =
                  generateController.selectedKelasFilter.value;
              final filteredHistori = histori.where((item) {
                final title = (item['title'] ?? '').toLowerCase();
                final kelas = (item['kelas'] ?? '').toLowerCase();
                final matchesQuery = query.isEmpty ||
                    title.contains(query) ||
                    kelas.contains(query);
                final matchesKelas = selectedKelas.isEmpty ||
                    kelas == selectedKelas.toLowerCase();
                return matchesQuery && matchesKelas;
              }).toList();

              if (filteredHistori.isEmpty) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: generateController.searchC,
                            focusNode: generateController.focusNodeS,
                            cursorColor: AllMaterial.colorBluePrimary,
                            onTapOutside: (_) =>
                                generateController.focusNodeS.unfocus(),
                            onChanged: (value) =>
                                generateController.searchQuery.value = value,
                            decoration: InputDecoration(
                              labelText: "Cari berdasarkan judul atau kelas...",
                              alignLabelWithHint: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: IconButton(
                                onPressed: () {
                                  generateController.searchQuery.value =
                                      generateController.searchC.text;
                                },
                                icon: Icon(Icons.search),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AllMaterial.colorGreySec),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: AllMaterial.colorBluePrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedKelas.isEmpty ? null : selectedKelas,
                            hint: const Text("Kelas"),
                            onChanged: (value) => generateController
                                .selectedKelasFilter.value = value ?? '',
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  isDark.value ? null : AllMaterial.colorWhite,
                              labelText: "Kelas",
                              alignLabelWithHint: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: AllMaterial.colorGreySec),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: AllMaterial.colorBluePrimary),
                              ),
                            ),
                            items: [
                              const DropdownMenuItem(
                                value: '',
                                child: Text("Semua"),
                              ),
                              ...histori
                                  .map((e) => e['kelas'])
                                  .toSet()
                                  .map((kelas) {
                                return DropdownMenuItem(
                                  value: kelas,
                                  child: Text(kelas),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          "Tidak ditemukan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                );
              }

              final grouped = <String, List<Map<String, dynamic>>>{};
              for (var item in filteredHistori.reversed) {
                final dateStr = item['tanggalDibuat'];
                grouped.putIfAbsent(dateStr, () => []).add(item);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: generateController.searchC,
                          focusNode: generateController.focusNodeS,
                          cursorColor: AllMaterial.colorBluePrimary,
                          onTapOutside: (_) =>
                              generateController.focusNodeS.unfocus(),
                          onChanged: (value) =>
                              generateController.searchQuery.value = value,
                          decoration: InputDecoration(
                            labelText: "Cari berdasarkan judul atau kelas...",
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: IconButton(
                              onPressed: () {
                                generateController.searchQuery.value =
                                    generateController.searchC.text;
                              },
                              icon: Icon(Icons.search),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 16),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AllMaterial.colorGreySec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                color: AllMaterial.colorBluePrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedKelas.isEmpty ? null : selectedKelas,
                          hint: const Text("Kelas"),
                          onChanged: (value) => generateController
                              .selectedKelasFilter.value = value ?? '',
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: "Kelas",
                            alignLabelWithHint: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 16,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide:
                                  BorderSide(color: AllMaterial.colorGreySec),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                color: AllMaterial.colorBluePrimary,
                              ),
                            ),
                          ),
                          items: [
                            const DropdownMenuItem(
                              value: '',
                              child: Text("Semua"),
                            ),
                            ...histori
                                .map((e) => e['kelas'])
                                .toSet()
                                .map((kelas) {
                              return DropdownMenuItem(
                                value: kelas,
                                child: Text(kelas),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // List Histori
                  ...grouped.entries.map((entry) {
                    final tanggal = entry.key;
                    final dataList = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tanggal,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...dataList.map((item) {
                          final jumlahKelompok =
                              (item['kelompok'] as List).length;
                          final id = item['id'];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onLongPress: () => selectedIds.add(id),
                              onTap: () {
                                if (isSelecting) {
                                  selectedIds.contains(id)
                                      ? selectedIds.remove(id)
                                      : selectedIds.add(id);
                                } else {
                                  Get.to(
                                    () => ReviewKelompokView(
                                      title: item['title'],
                                      kelas: item['kelas'],
                                      kelompok: item['kelompok'],
                                      kompetensi: item['kompetensi'],
                                      tanggalDibuat: item['tanggalDibuat'],
                                      tugas: item['tugas'],
                                      lampiranURL: item['lampiranURL'],
                                      tanggalDeadline: item['tanggalDeadline'],
                                      tanggalPresentasi:
                                          item['tanggalPresentasi'],
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xffD4D6DD),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    if (isSelecting)
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.transparent,
                                        child: Checkbox(
                                          activeColor:
                                              AllMaterial.colorBluePrimary,
                                          value: selectedIds.contains(id),
                                          onChanged: (checked) {
                                            if (checked == true) {
                                              selectedIds.add(id);
                                            } else {
                                              selectedIds.remove(id);
                                            }
                                          },
                                        ),
                                      )
                                    else
                                      CircleAvatar(
                                        backgroundColor: getKelasColor(
                                            extractJurusan(item['kelas'] ?? ''),
                                            context),
                                        radius: 24,
                                        child: SvgPicture.asset(
                                          "assets/images/group.svg",
                                          color: Colors.white,
                                          width: 28,
                                        ),
                                      ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['title'] ?? '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                item['kelas'] ?? '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.group,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '$jumlahKelompok kelompok',
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  const Icon(Icons.access_time,
                                                      size: 16,
                                                      color: Colors.grey),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    item['tanggalDibuat'],
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}

String extractJurusan(String kelas) {
  final parts = kelas.split(' ');
  return parts.length >= 2 ? parts[1].toUpperCase() : '';
}

Color getKelasColor(String jurusan, BuildContext context) {
  switch (jurusan.toUpperCase()) {
    case 'RPL':
      return AllMaterial.colorBluePrimary;
    case 'BDG':
    case 'BRT':
      return const Color(0xff2196F3);
    case 'ULW':
      return const Color.fromARGB(255, 181, 125, 104);
    case 'AKL':
    case 'LPS':
      return const Color.fromARGB(255, 79, 145, 82);
    case 'MPK':
      return const Color(0xff66BB6A);
    case 'TKJ':
      return const Color(0xffE53935);
    default:
      return Colors.grey[300]!;
  }
}
