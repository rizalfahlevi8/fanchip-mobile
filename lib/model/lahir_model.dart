class LahirModel {
  final int id;
  final int idHewan;
  final String? namaHewan; // Nullable
  final String? jenisHewan; // Nullable
  final String? tanggalKawin; // Nullable
  final String? tanggalLahir; // Nullable

  LahirModel({
    required this.id,
    required this.idHewan,
    this.namaHewan,
    this.jenisHewan,
    this.tanggalKawin,
    this.tanggalLahir,
  });

  factory LahirModel.fromJson(Map<String, dynamic> json) {
    return LahirModel(
      id: json['id'],
      idHewan: json['id_hewan'],
      namaHewan: json['nama_hewan'],
      jenisHewan: json['jenis_hewan'],
      tanggalKawin: json['tanggal_kawin'],
      tanggalLahir: json['tanggal_lahiran'],
    );
  }
}
