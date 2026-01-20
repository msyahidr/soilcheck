class PupukCalculator {
  // Bobot tanah olah (kg/ha)
  static const double bobotTanah = 2000000;

  // ================== UREA (N) ==================
  // N ANALISIS dalam PERSEN (%)
  static double hitungUrea({
    required double nPersen,
    required double kebutuhanN,
  }) {
    // % → fraksi
    final double nFraksi = nPersen / 100;

    // Total N dalam tanah (kg/ha)
    final double nTotal = nFraksi * bobotTanah;

    // N tersedia (1% dari N total)
    final double nTersedia = 0.01 * nTotal;

    // Konversi ke pupuk Urea (46% N)
    final double ureaSetara = (100 / 46) * nTersedia;

    // Dosis Urea aktual
    final double hasil = (kebutuhanN - ureaSetara) ;

    return hasil < 0 ? 0 : hasil;
  }

  // ================== SP-36 (P) ==================
  // P ANALISIS dalam PPM
  static double hitungSP36({
    required double pPpm,
    required double kebutuhanP,

  }) {
    // ppm → kg P
    final double pTotal = (pPpm * bobotTanah) / 1000000;

    // P → P2O5
    final double p2o5 = (142 / 62) * pTotal;

    // SP-36 setara
    final double sp36Setara = (100 / 36) * p2o5;

    final double hasil = (kebutuhanP - sp36Setara) ;
    return hasil < 0 ? 0 : hasil;
  }

  // ================== KCl (K) ==================
  // K ANALISIS dalam cmol(+)/kg
  static double hitungKCl({
    required double kCmol,        // cmol(+)/kg
    required double kebutuhanK,   // kg/ha KCl

  }) {
    const double bobotTanah = 2000000; // kg/ha

    // 1️⃣ K-dd total (kg/ha)
    final double kTotal =
        kCmol * 39 * bobotTanah / 1000000 * 10;

    // 2️⃣ K tersedia (10%)
    final double kTersedia = 0.10 * kTotal;

    // 3️⃣ K → K2O
    final double k2o = (94 / 78) * kTersedia;

    // 4️⃣ K2O → KCl
    final double kclSetara = (100 / 60) * k2o;

    // 5️⃣ KCl dibutuhkan
    final double hasil = (kebutuhanK - kclSetara) ;

    return hasil < 0 ? 0 : hasil;
  }

}
