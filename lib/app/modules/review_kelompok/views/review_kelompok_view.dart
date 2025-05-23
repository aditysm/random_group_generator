import 'package:flutter/material.dart';
import 'package:random_group_generator/all_material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewKelompokView extends StatelessWidget {
  final String title;
  final String kelas;
  final List<dynamic> kelompok;
  final String tugas;
  final String tanggalDibuat;
  final String tanggalPresentasi;
  final String tanggalDeadline;
  final String lampiranURL;
  final String kompetensi;

  const ReviewKelompokView({
    super.key,
    required this.title,
    required this.kelas,
    required this.kompetensi,
    required this.tanggalPresentasi,
    required this.lampiranURL,
    required this.tanggalDeadline,
    required this.tanggalDibuat,
    required this.tugas,
    required this.kelompok,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              final message = _generateWhatsappMessage(isToWa: false);
              AllMaterial.copyToClipboard(message);
            },
            child: Row(
              children: [
                Text(
                  '$title $kelas',
                  style: const TextStyle(fontWeight: AllMaterial.fontSemiBold),
                ),
                SizedBox(width: 3),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: 'Salin kelompok',
                  onPressed: () {
                    final message = _generateWhatsappMessage(isToWa: false);
                    AllMaterial.copyToClipboard(message);
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(padding: EdgeInsets.all(16)),
            tooltip: "Bagikan",
            onPressed: () {
              final message = _generateWhatsappMessage();
              SharePlus.instance.share(ShareParams(text: message));
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            // ignore: unused_local_variable
            final itemWidth =
                isMobile ? constraints.maxWidth : constraints.maxWidth / 2 - 24;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 600;
                      final itemWidth = isMobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 32) /
                              3;

                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: List.generate(kelompok.length, (index) {
                          final group = kelompok[index];
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: itemWidth,
                              maxWidth: itemWidth,
                            ),
                            child: IntrinsicHeight(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color(0xffD4D6DD)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kelompok ${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ...group.asMap().entries.map((entry) {
                                      final siswaIndex = entry.key;
                                      final siswa = entry.value;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text(
                                          '${siswaIndex + 1}. ${siswa["nama"]}',
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
                  const SizedBox(height: 24),
                  if (tugas.isNotEmpty)
                    Text(
                      "Deskripsi Tugas: $tugas",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (kompetensi.isNotEmpty)
                    Text(
                      "Poin Kompetensi: $kompetensi",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (lampiranURL.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          "Lampiran URL: ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              final uri = Uri.tryParse(lampiranURL);
                              if (uri != null && await canLaunchUrl(uri)) {
                                await launchUrl(uri,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                AllMaterial.messageScaffold(
                                  title: "URL tidak valid",
                                );
                              }
                            },
                            child: Text(
                              lampiranURL,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Text(
                    "Tanggal Presentasi: $tanggalPresentasi",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Tanggal Deadline: $tanggalDeadline",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Dibuat Pada: $tanggalDibuat",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _generateWhatsappMessage({bool isToWa = true}) {
    String message = isToWa ? "*$title $kelas*\n\n" : "$title $kelas\n\n";

    for (int i = 0; i < kelompok.length; i++) {
      message += "Kelompok ${i + 1}:\n";
      List<dynamic> group = kelompok[i];

      for (int j = 0; j < group.length; j++) {
        var siswa = group[j];
        message += "${j + 1}. ${siswa["nama"]}\n";
      }

      message += "\n";
    }

    if (tugas.isNotEmpty) {
      message += "Deskripsi Tugas: $tugas\n";
    }
    if (kompetensi.isNotEmpty) {
      message += "Poin Kompetensi: $kompetensi\n";
    }

    if (lampiranURL.isNotEmpty) {
      message += "Lampiran Tugas: $lampiranURL\n";
    }
    message += "\n";
    message += "Tanggal Presentasi: $tanggalPresentasi\n";
    message += "Tenggat Akhir: $tanggalDeadline\n";

    message += "Dibuat Pada: $tanggalDibuat\n";

    return message;
  }
}
