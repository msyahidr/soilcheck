import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../utils/api_service.dart';

class ResultPage extends StatelessWidget {
  final String tanaman;
  final double luas;

  final double nAnalisis;
  final double pAnalisis;
  final double kAnalisis;

  final double kebutuhanN;
  final double kebutuhanP;
  final double kebutuhanK;

  final double urea; // kg/ha
  final double sp36; // kg/ha
  final double kcl;  // kg/ha

  const ResultPage({
    super.key,
    required this.tanaman,
    required this.luas,
    required this.nAnalisis,
    required this.pAnalisis,
    required this.kAnalisis,
    required this.kebutuhanN,
    required this.kebutuhanP,
    required this.kebutuhanK,
    required this.urea,
    required this.sp36,
    required this.kcl,
  });

  @override
  Widget build(BuildContext context) {
    final totalUrea = urea * luas;
    final totalSp36 = sp36 * luas;
    final totalKcl = kcl * luas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Analisis Pemupukan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard(),
            const SizedBox(height: 16),
            _resultTable(
              urea,
              sp36,
              kcl,
              totalUrea,
              totalSp36,
              totalKcl,
            ),
            const SizedBox(height: 24),
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  // ================= UI =================

  Widget _infoCard() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.eco),
        title: Text(
          tanaman,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Luas Lahan : $luas ha'),
      ),
    );
  }

  Widget _resultTable(
      double urea,
      double sp36,
      double kcl,
      double totalUrea,
      double totalSp36,
      double totalKcl,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            _row(true, 'Jenis Pupuk', 'kg / ha', 'Total (kg)'),
            _row(false, 'Urea', urea, totalUrea),
            _row(false, 'SP-36', sp36, totalSp36),
            _row(false, 'KCl', kcl, totalKcl),
          ],
        ),
      ),
    );
  }

  TableRow _row(bool header, dynamic a, dynamic b, dynamic c) {
    return TableRow(
      decoration:
      header ? BoxDecoration(color: Colors.grey.shade200) : null,
      children: [
        _cell(a.toString(), header),
        _cell(
            b is double ? b.toStringAsFixed(2) : b.toString(), header),
        _cell(
            c is double ? c.toStringAsFixed(2) : c.toString(), header),
      ],
    );
  }

  Widget _cell(String text, bool header) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // ================= ACTION =================

  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Simpan ke Database'),
            onPressed: () async {
              final success = await ApiService.simpanHasil({
                "tanaman": tanaman,
                "luas": luas,
                "n_analisis": nAnalisis,
                "p_analisis": pAnalisis,
                "k_analisis": kAnalisis,
                "kebutuhan_n": kebutuhanN,
                "kebutuhan_p": kebutuhanP,
                "kebutuhan_k": kebutuhanK,
                "urea": urea,
                "sp36": sp36,
                "kcl": kcl,
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? 'Data berhasil disimpan'
                        : 'Gagal menyimpan data',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Export PDF'),
            onPressed: () async {
              await _generatePdf();
            },
          ),
        ),
      ],
    );
  }

  // ================= PDF =================

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'LAPORAN HASIL ANALISIS PEMUPUKAN',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text('Tanaman : $tanaman'),
              pw.Text('Luas Lahan : $luas ha'),
              pw.SizedBox(height: 16),
              pw.Table.fromTextArray(
                headers: ['Pupuk', 'kg / ha', 'Total (kg)'],
                data: [
                  [
                    'Urea',
                    urea.toStringAsFixed(2),
                    (urea * luas).toStringAsFixed(2)
                  ],
                  [
                    'SP-36',
                    sp36.toStringAsFixed(2),
                    (sp36 * luas).toStringAsFixed(2)
                  ],
                  [
                    'KCl',
                    kcl.toStringAsFixed(2),
                    (kcl * luas).toStringAsFixed(2)
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
