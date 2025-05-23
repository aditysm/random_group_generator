import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:random_group_generator/all_material.dart';

class GenerateKelompokController extends GetxController {
  var namaKelas = [
    "XI RPL 1",
    "XI RPL 2",
    "XI TKJ 1",
    "XI TKJ 2",
    "XI TKJ 3",
    "XI AKL 1",
    "XI AKL 2",
    "XI AKL 3",
    "XI MPK 1",
    "XI MPK 2",
    "XI BDG 1",
    "XI BDG 2",
    "XI BRT 1",
    "XI BRT 2",
    "XI ULW 1",
    "XI ULW 2",
    "XII RPL 1",
    "XII RPL 2",
    "XII RPL 3",
    "XII TKJ 1",
    "XII TKJ 2",
    "XII TKJ 3",
    "XII AKL 1",
    "XII AKL 2",
    "XII MPK 1",
    "XII MPK 2",
    "XII BDG",
    "XII BRT 1",
    "XII BRT 2",
    "XII ULW",
    "XII LPS",
  ].obs;
  var selectedKelas = ''.obs;
  var kelasTerpilih = <dynamic>[].obs;
  var jumlahSiswaTerpilih = <dynamic>[].obs;
  var anggotaKelas = <dynamic>[].obs;
  var titleKelompok = "".obs;
  var tugasKelompok = "".obs;
  var jumlahKelompokSet = "";
  var jumlahAnggotaKelompokSet = "";

  final Map<String, String> kelasJsonMap = {
    "XI RPL 1": 'assets/json/24/rpl1.json',
    "XI RPL 2": 'assets/json/24/rpl2.json',
    "XI TKJ 1": 'assets/json/24/tkj1.json',
    "XI TKJ 2": 'assets/json/24/tkj2.json',
    "XI TKJ 3": 'assets/json/24/tkj3.json',
    "XI AKL 1": 'assets/json/24/akl1.json',
    "XI AKL 2": 'assets/json/24/akl2.json',
    "XI AKL 3": 'assets/json/24/akl3.json',
    "XI MPK 1": 'assets/json/24/mpk1.json',
    "XI MPK 2": 'assets/json/24/mpk2.json',
    "XI BDG 1": 'assets/json/24/bdg1.json',
    "XI BDG 2": 'assets/json/24/bdg2.json',
    "XI BRT 1": 'assets/json/24/brt1.json',
    "XI BRT 2": 'assets/json/24/brt2.json',
    "XI ULW 1": 'assets/json/24/ulw1.json',
    "XI ULW 2": 'assets/json/24/ulw2.json',
    "XII RPL 1": 'assets/json/23/rpl1.json',
    "XII RPL 2": 'assets/json/23/rpl2.json',
    "XII RPL 3": 'assets/json/23/rpl3.json',
    "XII TKJ 1": 'assets/json/23/tkj1.json',
    "XII TKJ 2": 'assets/json/23/tkj2.json',
    "XII TKJ 3": 'assets/json/23/tkj3.json',
    "XII AKL 1": 'assets/json/23/akl1.json',
    "XII AKL 2": 'assets/json/23/akl2.json',
    "XII MPK 1": 'assets/json/23/mpk1.json',
    "XII MPK 2": 'assets/json/23/mpk2.json',
    "XII BDG": 'assets/json/23/bdg.json',
    "XII BRT 1": 'assets/json/23/brt1.json',
    "XII BRT 2": 'assets/json/23/brt2.json',
    "XII ULW": 'assets/json/23/ulw.json',
    "XII LPS": 'assets/json/23/lps.json',
  };

  void kelasDipilih(String value) async {
    if (kelasJsonMap.containsKey(value)) {
      var data = await rootBundle.loadString(kelasJsonMap[value]!);
      List<dynamic> jsonResult = jsonDecode(data);

      anggotaKelas.clear();

      for (var i = 0; i < jsonResult.length; i++) {
        if (jsonResult[i]["nama"] is String) {
          anggotaKelas.add(jsonResult[i]["nama"]);
        } else {
          print("Data tidak valid: ${jsonResult[i]["nama"]}");
        }
      }

      kelasTerpilih.assignAll(jsonResult..shuffle());
    } else {
      kelasTerpilih.clear();
      anggotaKelas.clear();
    }
    update();
  }

  var selectedKetua = <String>[].obs;

  void pilihKetua(String nama) {
    var jumlahKetua = int.tryParse(jumlahKelompokSet);
    if (selectedKetua.contains(nama)) {
      selectedKetua.remove(nama);
    } else {
      if (selectedKetua.length < jumlahKetua!) {
        selectedKetua.add(nama);
      } else {
        AllMaterial.messageScaffold(
            title: "Anda hanya dapat memilih $jumlahKetua ketua.");
      }
    }
  }

  void toggleSelection(String value) {
    if (selectedKelas.value == value) {
      selectedKelas.value = '';
      kelasTerpilih.clear();
    } else {
      selectedKelas.value = value;
      kelasDipilih(value);
    }
    update();
  }

  void jumlahSiswa() {
    if (kelasTerpilih.isNotEmpty) {
      jumlahSiswaTerpilih.assignAll(kelasTerpilih.reversed);
    }
    update();
  }

  var kelompokList = <List<dynamic>>[].obs;

  void generateKelompok() {
    final siswaTerpilih = List<String>.from(
      jumlahSiswaTerpilih.map((siswa) => siswa['nama'] as String),
    );
    final ketuaTerpilih = List<String>.from(selectedKetua);
    siswaTerpilih.removeWhere((siswa) => ketuaTerpilih.contains(siswa));

    final rng = Random(DateTime.now().millisecondsSinceEpoch);
    siswaTerpilih.shuffle(rng);
    ketuaTerpilih.shuffle(rng);

    final jumlahKelompok = int.tryParse(jumlahKelompokSet) ?? 1;
    // ignore: unused_local_variable
    final jumlahAnggotaPerKelompok = int.tryParse(jumlahAnggotaKelompokSet) ??
        ((siswaTerpilih.length + ketuaTerpilih.length) / jumlahKelompok).ceil();

    kelompokList.clear();
    for (int i = 0; i < jumlahKelompok; i++) {
      kelompokList.add([]);
    }

    for (int i = 0; i < ketuaTerpilih.length; i++) {
      final index = i % jumlahKelompok;
      kelompokList[index].add({
        'nama': ketuaTerpilih[i],
      });
    }

    for (int i = 0; i < siswaTerpilih.length; i++) {
      final index = i % jumlahKelompok;
      kelompokList[index].add({
        'nama': siswaTerpilih[i],
      });
    }

    // Role otomatis
    if (isRole.value) {
      if (isRoleAuto.value) {
        final roles = ['Ketua', 'Penulis', 'Penyaji', 'Peneliti'];

        for (var kelompok in kelompokList) {
          for (int i = 0; i < kelompok.length; i++) {
            final namaAsli = kelompok[i]['nama'];
            final role = i < roles.length ? roles[i] : 'Anggota';
            kelompok[i]['nama'] = '$namaAsli ($role)';
          }
        }
      } else {
        for (var kelompok in kelompokList) {
          for (int i = 0; i < kelompok.length; i++) {
            final namaAsli = kelompok[i]['nama'];

            String role;
            if (roleList.isEmpty) {
              role = i == 0 ? 'Ketua' : 'Anggota';
            } else {
              role = i < roleList.length ? roleList[i] : 'Anggota';
            }

            kelompok[i]['nama'] = '$namaAsli ($role)';
          }
        }
      }
    }

    update();

    addToHistory(
      titleKelompok.value,
      selectedKelas.value,
      kelompokList,
      tugasKelompok.value,
      poinC.text,
      DateTime.now(),
      presentasi.value ?? DateTime.now().add(Duration(hours: 6)),
      deadline.value ?? DateTime.now().add(Duration(days: 7)),
      urlC.text,
    );
  }

  // Text Editing Controllers
  TextEditingController titleC = TextEditingController();
  TextEditingController poinC = TextEditingController();
  TextEditingController tugasC = TextEditingController();
  TextEditingController jumlahKelompok = TextEditingController();
  TextEditingController jumlahAnggotaKelompok = TextEditingController();

  final TextEditingController urlC = TextEditingController();
  final TextEditingController newMateriC = TextEditingController();
  final RxBool isRoleAuto = false.obs;
  final RxBool isRole = true.obs;

  final Rxn<DateTime> deadline = Rxn<DateTime>();
  final Rxn<DateTime> presentasi = Rxn<DateTime>();

  final RxList<String> materiList = <String>[].obs;
  final RxList<String> roleList = <String>[].obs;
  FocusNode focusNodeC = FocusNode();
  FocusNode focusNodeU = FocusNode();
  FocusNode focusNodeT = FocusNode();
  FocusNode focusNodeS = FocusNode();
  FocusNode focusNodeP = FocusNode();
  FocusNode focusNodeJ = FocusNode();
  FocusNode focusNodeA = FocusNode();

  void setJumlahKelompok() {
    if (jumlahKelompok.text.isNotEmpty) {
      jumlahKelompokSet = jumlahKelompok.text.toUpperCase();
    } else {
      jumlahKelompokSet = "6";
    }
    update();
  }

  final materiInputC = TextEditingController();
  final focusNodeM = FocusNode();

  final roleInputC = TextEditingController();
  final focusNodeR = FocusNode();

  void addMateri(String value) {
    if (!materiList.contains(value)) {
      materiList.add(value);
    }
  }

  void removeMateri(String value) {
    materiList.remove(value);
  }

  void addRole(String value) {
    if (!roleList.contains(value)) {
      roleList.add(value);
    }
  }

  void removeRole(String value) {
    roleList.remove(value);
  }

  void setTitle() {
    if (titleC.text.isNotEmpty) {
      titleKelompok.value = "KELOMPOK ${titleC.text.toUpperCase()}";
    } else {
      titleKelompok.value = "KELOMPOK";
    }
    update();
  }

  void setTugas() {
    if (tugasC.text.isNotEmpty) {
      tugasKelompok.value = tugasC.text;
    } else {
      tugasKelompok.value = "";
    }
    update();
  }

  var currentStep = 1.obs;

  void setCurrentStep(int step) {
    currentStep.value = step;
  }

  // Dark Mode
  RxBool isDarkMode = false.obs;
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    print(_storage.read("isDarkMode"));
  }

  // Histori
  final GetStorage _storage = GetStorage();
  var histori = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
    isDarkMode.value = _storage.read('isDarkMode') ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    });
  }

  void loadHistory() {
    var storedHistory = _storage
            .read<List<dynamic>>('histori')
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];
    histori.value = storedHistory;
  }

  void addToHistory(
      String title,
      String kelas,
      List kelompok,
      String tugas,
      String kompetensi,
      DateTime tanggalDibuat,
      DateTime tanggalPresentasi,
      DateTime tanggalDeadline,
      String lampiranURL) {
    List copiedKelompok = kelompok.map((group) => List.from(group)).toList();

    histori.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'kelas': kelas,
      'kelompok': copiedKelompok,
      'tugas': tugas,
      'kompetensi': kompetensi,
      'tanggalDibuat':
          DateFormat('EEEE, d MMMM yyyy', 'id').format(tanggalDibuat),
      'tanggalPresentasi':
          DateFormat("dd MMM yyyy – HH:mm", 'id').format(tanggalPresentasi),
      'tanggalDeadline':
          DateFormat("dd MMM yyyy – HH:mm", 'id').format(tanggalDeadline),
      'lampiranURL': lampiranURL
    });
    _storage.write('histori', histori.toList());
    update();
  }

  final RxString searchQuery = ''.obs;
  var searchC = TextEditingController();
  final RxString selectedKelasFilter = ''.obs;

  void removeHistoryByIds(List<String> ids) {
    histori.removeWhere((item) => ids.contains(item['id']));
    histori.refresh();
  }

  void removeFromHistory(int index) {
    histori.removeAt(index);
    histori.refresh();
    _storage.write('histori', histori.toList());
  }

  void clearHistory() {
    histori.clear();
    _storage.remove('histori');
  }

  void resetState() {
    currentStep.value = 1;
    kelasTerpilih.clear();
    titleC.clear();
    jumlahKelompok.clear();
    jumlahAnggotaKelompok.clear();
    selectedKelas.value = "";
    kelasDipilih("Clear");
    jumlahSiswaTerpilih.clear();
    titleKelompok.value = 'KELOMPOK';
    materiInputC.text = '';
    urlC.text = '';
    presentasi.value = null;
    deadline.value = null;
    tugasKelompok.value = '';
    jumlahKelompokSet = '';
    jumlahAnggotaKelompokSet = '';
    isRoleAuto.value = false;
    isRole.value = false;
    poinC.clear();
    tugasC.clear();
    kelompokList.clear();
    selectedKetua.clear();
    materiList.clear();
    roleList.clear();
    update();
  }
}
