class HewanModel {
  final String id;
  final String nama;
  final String? jenis;
  final String? jenis_id;
  final String pemeriksaan_fisik;
  final String pemeriksaan_lanjutan;

  const HewanModel(
      {required this.id,
      required this.nama,
      this.jenis,
      this.jenis_id,
      required this.pemeriksaan_fisik,
      required this.pemeriksaan_lanjutan});

  factory HewanModel.fromJson(Map<String, dynamic> json) {
    return HewanModel(
        id: json['id'].toString(),
        nama: json['nama'] as String,
        jenis: json['jenis'] as String?,
        jenis_id: json['jenis_id']?.toString(),
        pemeriksaan_fisik: json['pemeriksaan_fisik'] as String,
        pemeriksaan_lanjutan: json['pemeriksaan_lanjutan'] as String
        );
  }
}
