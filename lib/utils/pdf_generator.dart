import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {
  static Future<void> generate({
    required String tanaman,
    required double luas,
    required double urea,
    required double sp36,
    required double kcl,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'LAPORAN HASIL PEMUPUKAN',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Text('Tanaman : $tanaman'),
            pw.Text('Luas Lahan : $luas ha'),
            pw.SizedBox(height: 12),
            pw.Table.fromTextArray(
              headers: ['Pupuk', 'kg/ha', 'Total (kg)'],
              data: [
                ['Urea', urea.toStringAsFixed(2),
                  (urea * luas).toStringAsFixed(2)],
                ['SP-36', sp36.toStringAsFixed(2),
                  (sp36 * luas).toStringAsFixed(2)],
                ['KCl', kcl.toStringAsFixed(2),
                  (kcl * luas).toStringAsFixed(2)],
              ],
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
