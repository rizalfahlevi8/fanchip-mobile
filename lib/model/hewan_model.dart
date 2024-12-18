class HewanModel {
  final String id;
  final String nama;
  final String? code_hewan;
  final String? jenis;
  final String? jenis_id;
  final String? pemeriksaan_fisik;
  final String? pemeriksaan_lanjutan;

  const HewanModel(
      {required this.id,
      required this.nama,
      this.code_hewan,
      this.jenis,
      this.jenis_id,
      this.pemeriksaan_fisik,
      this.pemeriksaan_lanjutan});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HewanModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory HewanModel.fromJson(Map<String, dynamic> json) {
    return HewanModel(
        id: json['id'].toString(),
        nama: json['nama'] as String,
        code_hewan: json['code_hewan'] as String?,
        jenis: json['jenis'] as String?,
        jenis_id: json['jenis_id']?.toString(),
        pemeriksaan_fisik: json['pemeriksaan_fisik'] as String?,
        pemeriksaan_lanjutan: json['pemeriksaan_lanjutan'] as String?);
  }
}
