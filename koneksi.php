<?php
$conn = new mysqli("localhost", "root", "", "soilcheck");

if ($conn->connect_error) {
  die("Koneksi gagal");
}
