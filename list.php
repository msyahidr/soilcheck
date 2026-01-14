<?php
include 'koneksi.php';
$result = $conn->query("SELECT * FROM hasil_analisis ORDER BY created_at DESC");
$data = [];
while ($row = $result->fetch_assoc()) {
  $data[] = $row;
}
echo json_encode($data);
    