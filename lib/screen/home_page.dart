import 'package:fanchip_mobile/model/user_model.dart';
import 'package:fanchip_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fanchip_mobile/components/hewan_card.dart';
import 'package:fanchip_mobile/model/hewan_model.dart';
import 'package:fanchip_mobile/services/hewan_service.dart';
import 'package:fanchip_mobile/services/jenis_service.dart';
import 'package:fanchip_mobile/utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listJenis = [];
  List listHewan = [];
  UserModel? user;

  HewanService hewanService = HewanService();
  JenisService jenisService = JenisService();
  AuthService userService = AuthService();

  getData() async {
    listJenis = await jenisService.getDataJenis() ?? [];
    listHewan = await hewanService.getDataHewan() ?? [];
    user = await userService.getDataUserId();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void showHewanDetailDialog(BuildContext context, HewanModel hewan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Text
                Center(
                  child: Text(
                    hewan.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.green,
                  thickness: 1.5,
                ),
                const SizedBox(height: 8),
                // Details
                Text(
                  'Jenis: ${hewan.jenis}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pemeriksaan fisik: ${hewan.pemeriksaan_fisik ?? "Tidak ada data"}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pemeriksaan lanjutan: ${hewan.pemeriksaan_lanjutan ?? "Tidak ada data."}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final result =
                                  await hewanService.deleteHewan(hewan.id);

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
                                  .popAndPushNamed('/editHewan', arguments: [
                                hewan.id,
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

  void showJenisDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Daftar Jenis Hewan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/addJenis');
                      },
                      child: const CircleAvatar(
                        radius: 10,
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.green,
                  thickness: 1.5,
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: listJenis.length,
                    itemBuilder: (BuildContext context, int index) {
                      var jenis = listJenis[index];
                      return ListTile(
                        title: Text(
                          jenis.nama,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .pushNamed('/editJenis', arguments: [
                                  jenis.id,
                                ]);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final result =
                                    await jenisService.deleteJenis(jenis.id);

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
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addHewan');
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user?.nama ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/me');
                      },
                      child: const SizedBox(
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ],
                ),
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Jenis Kambing',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showJenisDialog(context);
                      },
                      child: const CircleAvatar(
                        radius: 13,
                        child: Icon(Icons.more_horiz),
                      ),
                    ),
                  ],
                ),
                Config.spaceSmall,
                // Menambahkan pengecekan apakah listJenis kosong
                listJenis.isEmpty
                    ? const Center(child: Text('Data kosong'))
                    : SizedBox(
                        height: Config.heightSize * 0.07,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                              List<Widget>.generate(listJenis.length, (index) {
                            return Card(
                              margin: const EdgeInsets.only(right: 20),
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      listJenis[index].nama,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                Config.spaceSmall,
                const Text(
                  'Kambing',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                // Menambahkan pengecekan apakah listHewan kosong
                listHewan.isEmpty
                    ? const Center(child: Text('Data kosong'))
                    : Column(
                        children: List.generate(
                          listHewan.length,
                          (index) {
                            var hewan = listHewan[index] as HewanModel;
                            return GestureDetector(
                              onTap: () {
                                showHewanDetailDialog(context, hewan);
                              },
                              child: HewanCard(
                                nama: hewan.nama,
                                jenis: hewan.jenis!,
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
