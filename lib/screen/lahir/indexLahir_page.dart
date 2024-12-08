import 'package:fanchip_mobile/components/lahir_card.dart';
import 'package:fanchip_mobile/model/lahir_model.dart';
import 'package:fanchip_mobile/services/lahir_service.dart';
import 'package:fanchip_mobile/utils/config.dart';
import 'package:flutter/material.dart';

class IndexlahirPage extends StatefulWidget {
  const IndexlahirPage({super.key});

  @override
  State<IndexlahirPage> createState() => _IndexlahirPageState();
}

class _IndexlahirPageState extends State<IndexlahirPage> {
  List listLahir = [];

  LahirService lahirService = LahirService();

  getData() async {
    listLahir = await lahirService.getDataLahir() ?? [];
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  // Fungsi untuk menampilkan popup dengan desain lebih menarik
  void showDetailDialog(LahirModel lahir) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15), // Untuk membulatkan sudut dialog
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gambar jika ada (misalnya gambar hewan)
                const Icon(
                  Icons.pets,
                  size: 50,
                  color: Colors.orange,
                ),
                const SizedBox(height: 10),
                Text(
                  lahir.namaHewan ?? 'Nama Hewan Tidak Diketahui',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Jenis Hewan: ${lahir.jenisHewan ?? 'Tidak diketahui'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Tanggal Kawin: ${lahir.tanggalKawin ?? 'Tanggal tidak tersedia'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Estimasi Melahirkan: ${lahir.tanggalLahir ?? 'Tanggal tidak tersedia'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await lahirService
                                  .deleteLahir(lahir.id.toString());

                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data berhasil dihapus!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pop(context);
                                await getData(); // Memuat ulang data dari server
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data gagal dihapus!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Warna tombol
                            ),
                            child: const Text('Delete',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed('/editLahir', arguments: [
                                lahir.id,
                              ]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, // Warna tombol
                            ),
                            child: const Text('update',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addLahir');
        },
        child: const Icon(Icons.pending_actions),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Masa Kehamilan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                Column(
                  children: List.generate(listLahir.length, (index) {
                    var lahir = listLahir[index] as LahirModel;
                    return GestureDetector(
                      onTap: () {
                        showDetailDialog(
                            lahir); // Menampilkan popup saat card ditekan
                      },
                      child: LahirCard(
                        nama: lahir.namaHewan ?? 'Tidak diketahui',
                        jenis: lahir.jenisHewan ?? 'Tidak diketahui',
                        tanggal_lahir:
                            lahir.tanggalLahir ?? 'Tanggal tidak tersedia',
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
