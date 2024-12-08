import 'package:fanchip_mobile/components/button.dart';
import 'package:fanchip_mobile/model/jenis_model.dart';
import 'package:fanchip_mobile/services/hewan_service.dart';
import 'package:fanchip_mobile/services/jenis_service.dart';
import 'package:flutter/material.dart';

class CreatehewanPage extends StatefulWidget {
  const CreatehewanPage({super.key});

  @override
  State<CreatehewanPage> createState() => _CreatehewanPageState();
}

class _CreatehewanPageState extends State<CreatehewanPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pemeriksaanLanjutanController = TextEditingController();
  final _pemeriksaanFisikController = TextEditingController();

  String? _selectedJenisKambing;
  List<JenisModel> listJenis = [];

  final JenisService jenisService = JenisService();
  final HewanService hewanService = HewanService();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final data = await jenisService.getDataJenis();
    if (data != null) {
      setState(() {
        listJenis = data;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pemeriksaanLanjutanController.dispose();
    _pemeriksaanFisikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kambing'),
      ),
      body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Menambahkan Data',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Input Nama Kambing
                                TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: 'Nama Kambing',
                                    labelText: 'Nama Kambing',
                                    prefixIcon: const Icon(Icons.pets),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama Kambing wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),

                                // Dropdown Jenis Kambing
                                DropdownButtonFormField<String>(
                                  value: _selectedJenisKambing,
                                  decoration: InputDecoration(
                                    labelText: 'Jenis Kambing',
                                    prefixIcon: const Icon(Icons.category),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  items: listJenis
                                      .map(
                                        (jenis) => DropdownMenuItem(
                                          value: jenis.id,
                                          child: Text(jenis.nama),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedJenisKambing = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Pilih jenis kambing';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),

                                // Input Pemeriksaan Fisik
                                TextFormField(
                                  controller: _pemeriksaanFisikController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Pemeriksaan Fisik',
                                    labelText: 'Pemeriksaan Fisik',
                                    prefixIcon:
                                        const Icon(Icons.health_and_safety),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Pemeriksaan Fisik wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),

                                // Input Pemeriksaan Lanjutan
                                TextFormField(
                                  controller: _pemeriksaanLanjutanController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Pemeriksaan Lanjutan',
                                    labelText: 'Pemeriksaan Lanjutan',
                                    prefixIcon: const Icon(Icons.description),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Pemeriksaan Lanjutan wajib diisi';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Button(
                                    width: double.infinity,
                                    title: "Submit",
                                    disable: false,
                                    onPressed: () async {
                                      final result =
                                          await hewanService.postHewan(
                                              _nameController.text,
                                              _selectedJenisKambing!,
                                              _pemeriksaanFisikController.text,
                                              _pemeriksaanLanjutanController
                                                  .text);

                                      if (result) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Data berhasil ditambahkan!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.of(context)
                                            .popAndPushNamed('/home');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Reservasi gagal!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
