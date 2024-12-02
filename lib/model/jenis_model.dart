class JenisModel {
  final String id;
  final String nama;

  const JenisModel({
    required this.id,
    required this.nama,
  });

  factory JenisModel.fromJson(Map<String, dynamic> json) {
    return JenisModel(
      id: json['id'].toString(),
      nama: json['nama'] as String,
    );
  }
}
