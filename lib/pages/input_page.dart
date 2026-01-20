import 'package:flutter/material.dart';
import '../utils/calculator.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // ===== CONTROLLERS =====
  final TextEditingController luasCtrl = TextEditingController();
  final TextEditingController nCtrl = TextEditingController();
  final TextEditingController pCtrl = TextEditingController();
  final TextEditingController kCtrl = TextEditingController();
  final TextEditingController kebutuhanNCtrl = TextEditingController();
  final TextEditingController kebutuhanPCtrl = TextEditingController();
  final TextEditingController kebutuhanKCtrl = TextEditingController();

  String tanaman = "Sawit";
  double? urea, sp36, kcl;

  // ================= HITUNG =================
  void hitung() {
    if ([
      luasCtrl,
      nCtrl,
      pCtrl,
      kCtrl,
      kebutuhanNCtrl,
      kebutuhanPCtrl,
      kebutuhanKCtrl
    ].any((e) => e.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data wajib diisi')),
      );
      return;
    }

    final double? luas =
    double.tryParse(luasCtrl.text.replaceAll(',', '.'));
    final double? n =
    double.tryParse(nCtrl.text.replaceAll(',', '.'));
    final double? p =
    double.tryParse(pCtrl.text.replaceAll(',', '.'));
    final double? k =
    double.tryParse(kCtrl.text.replaceAll(',', '.'));
    final double? kebutuhanN =
    double.tryParse(kebutuhanNCtrl.text.replaceAll(',', '.'));
    final double? kebutuhanP =
    double.tryParse(kebutuhanPCtrl.text.replaceAll(',', '.'));
    final double? kebutuhanK =
    double.tryParse(kebutuhanKCtrl.text.replaceAll(',', '.'));

    if ([luas, n, p, k, kebutuhanN, kebutuhanP, kebutuhanK]
        .contains(null) ||
        luas! <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input tidak valid')),
      );
      return;
    }

    setState(() {
      urea = PupukCalculator.hitungUrea(
        nPersen: n!,
        kebutuhanN: kebutuhanN!,
      );
      sp36 = PupukCalculator.hitungSP36(
        pPpm: p!,
        kebutuhanP: kebutuhanP!,
      );
      kcl = PupukCalculator.hitungKCl(
        kCmol: k!,
        kebutuhanK: kebutuhanK!,
      );
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        title: const Text('SoilCheck'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _cardSection(
              title: 'Data Tanaman',
              icon: Icons.eco,
              color: Colors.green.shade50,
              children: [
                _dropdownTanaman(),
                _field('Luas Lahan (ha)', luasCtrl, Icons.map),
              ],
            ),
            _cardSection(
              title: 'Analisis Tanah',
              icon: Icons.science,
              color: Colors.lightGreen.shade50,
              children: [
                _field('N Analisis (%)', nCtrl, Icons.percent),
                _field('P Analisis (ppm)', pCtrl, Icons.bubble_chart),
                _field('K Analisis (cmol(+)/kg)', kCtrl, Icons.grass),
              ],
            ),
            _cardSection(
              title: 'Kebutuhan Tanaman (kg/ha)',
              icon: Icons.assignment,
              color: Colors.teal.shade50,
              children: [
                _field('Kebutuhan N', kebutuhanNCtrl, Icons.trending_up),
                _field('Kebutuhan P', kebutuhanPCtrl, Icons.trending_up),
                _field('Kebutuhan K', kebutuhanKCtrl, Icons.trending_up),
              ],
            ),
            const SizedBox(height: 20),

            // === BUTTON HITUNG ===
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text(
                  'Hitung Kebutuhan Pupuk',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: hitung,
              ),
            ),

            const SizedBox(height: 12),

            // === BUTTON HASIL ===
            if (urea != null)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.visibility),
                  label: const Text('Lihat Hasil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultPage(
                          tanaman: tanaman,
                          luas: double.parse(
                              luasCtrl.text.replaceAll(',', '.')),
                          nAnalisis:
                          double.parse(nCtrl.text.replaceAll(',', '.')),
                          pAnalisis:
                          double.parse(pCtrl.text.replaceAll(',', '.')),
                          kAnalisis:
                          double.parse(kCtrl.text.replaceAll(',', '.')),
                          kebutuhanN: double.parse(
                              kebutuhanNCtrl.text.replaceAll(',', '.')),
                          kebutuhanP: double.parse(
                              kebutuhanPCtrl.text.replaceAll(',', '.')),
                          kebutuhanK: double.parse(
                              kebutuhanKCtrl.text.replaceAll(',', '.')),
                          urea: urea!,
                          sp36: sp36!,
                          kcl: kcl!,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ========== COMPONENT ==========
  Widget _cardSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) =>
      Card(
        color: color,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              ...children,
            ],
          ),
        ),
      );

  Widget _field(
      String label, TextEditingController controller, IconData icon) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: controller,
          keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.green.shade700),
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      );

  Widget _dropdownTanaman() => DropdownButtonFormField<String>(
    value: tanaman,
    items: const [
      DropdownMenuItem(value: 'Sawit', child: Text('Sawit')),
    ],
    onChanged: (v) => setState(() => tanaman = v!),
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.eco, color: Colors.green.shade700),
      labelText: 'Nama Tanaman',
      filled: true,
      fillColor: Colors.white,
      border:
      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
