class UserModel {
  final String id;
  final String nama;
  final String email;
  final String alamat;
  final String no_telp;

  const UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.no_telp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      nama: json['nama'] as String,
      email: json['email'] as String,
      alamat: json['alamat'] as String,
      no_telp: json['no_telp'] as String,
    );
  }
}
