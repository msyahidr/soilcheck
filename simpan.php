<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");

$conn = new mysqli("localhost", "root", "", "soilcheck");

if ($conn->connect_error) {
  echo json_encode([
    "status" => "error",
    "msg" => "Koneksi DB gagal"
  ]);
  exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
  echo json_encode([
    "status" => "error",
    "msg" => "Data JSON kosong"
  ]);
  exit;
}

$tanaman = $data['tanaman'];
$luas = (float)$data['luas'];
$n_analisis = (float)$data['n_analisis'];
$p_analisis = (float)$data['p_analisis'];
$k_analisis = (float)$data['k_analisis'];
$kebutuhan_n = (float)$data['kebutuhan_n'];
$kebutuhan_p = (float)$data['kebutuhan_p'];
$kebutuhan_k = (float)$data['kebutuhan_k'];
$urea = (float)$data['urea'];
$sp36 = (float)$data['sp36'];
$kcl = (float)$data['kcl'];

$sql = "INSERT INTO hasil_analisis 
(tanaman, luas, n_analisis, p_analisis, k_analisis, kebutuhan_n, kebutuhan_p, kebutuhan_k, urea, sp36, kcl)
VALUES
('$tanaman', $luas, $n_analisis, $p_analisis, $k_analisis, $kebutuhan_n, $kebutuhan_p, $kebutuhan_k, $urea, $sp36, $kcl)";

if ($conn->query($sql)) {
  echo json_encode([
    "status" => "success"
  ]);
} else {
  echo json_encode([
    "status" => "error",
    "msg" => $conn->error
  ]);
}

$conn->close();
