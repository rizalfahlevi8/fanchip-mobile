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
                      onTap: () {},
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
          )),
        ));
  }
}
