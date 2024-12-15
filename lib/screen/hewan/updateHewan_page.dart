import 'package:flutter/material.dart';
import 'package:fanchip_mobile/components/button.dart';
import 'package:fanchip_mobile/model/jenis_model.dart';
import 'package:fanchip_mobile/services/hewan_service.dart';
import 'package:fanchip_mobile/services/jenis_service.dart';

class UpdatehewanPage extends StatefulWidget {
  const UpdatehewanPage({super.key});

  @override
  State<UpdatehewanPage> createState() => _UpdatehewanPageState();
}

class _UpdatehewanPageState extends State<UpdatehewanPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _pemeriksaanLanjutanController = TextEditingController();
  final _pemeriksaanFisikController = TextEditingController();

  String? _codeError;

  String? _selectedJenisKambing;
  List<JenisModel> listJenis = [];
  String? _hewanId;

  final JenisService jenisService = JenisService();
  final HewanService hewanService = HewanService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as List<String>;
      if (args.isNotEmpty) {
        _hewanId = args.first;
        getHewanData(_hewanId!);
      }
      getData();
    });
  }

  Future<void> getData() async {
    final data = await jenisService.getDataJenis();
    if (data != null) {
      setState(() {
        listJenis = data;
      });
    }
  }

  Future<void> getHewanData(String id) async {
    final hewanData = await hewanService.getDataHewanId(id);
    if (hewanData != null) {
      setState(() {
        _codeController.text = hewanData.code_hewan ?? '';
        _nameController.text = hewanData.nama ?? '';
        _pemeriksaanFisikController.text = hewanData.pemeriksaan_fisik ?? '';
        _pemeriksaanLanjutanController.text =
            hewanData.pemeriksaan_lanjutan ?? '';
        _selectedJenisKambing = hewanData.jenis_id;

        // Jika jenis_id tidak ditemukan, tambahkan sementara
        if (!listJenis.any((jenis) => jenis.id == hewanData.jenis_id)) {
          listJenis.insert(
            0,
            JenisModel(id: hewanData.jenis_id, nama: 'Jenis Tidak Diketahui'),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _pemeriksaanLanjutanController.dispose();
    _pemeriksaanFisikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Kambing'),
      ),
      body: listJenis.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            'Edit Data Kambing',
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
                                // Input Kode Kambing
                                TextFormField(
                                  controller: _codeController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: 'ID Kambing',
                                    labelText: 'ID Kambing',
                                    prefixIcon: const Icon(Icons.abc),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ID Kambing wajib diisi';
                                    }
                                    if (_codeError != null) {
                                      return _codeError;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),

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
                                  value: listJenis.any((jenis) =>
                                          jenis.id == _selectedJenisKambing)
                                      ? _selectedJenisKambing
                                      : null,
                                  decoration: InputDecoration(
                                    labelText: 'Jenis Kambing',
                                    prefixIcon: const Icon(Icons.category),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('Pilih Jenis Kambing'),
                                    ),
                                    ...listJenis.map(
                                      (jenis) => DropdownMenuItem(
                                        value: jenis.id,
                                        child: Text(jenis.nama),
                                      ),
                                    ),
                                  ],
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
                                  title: "Update",
                                  disable: false,
                                  onPressed: () async {
                                    setState(() {
                                      _codeError = null;
                                    });

                                    if (_formKey.currentState!.validate()) {
                                      final result =
                                          await hewanService.updateHewan(
                                        _hewanId!,
                                        _codeController.text,
                                        _nameController.text,
                                        _selectedJenisKambing!,
                                        _pemeriksaanFisikController.text,
                                        _pemeriksaanLanjutanController.text,
                                      );

                                      if (result != null && result['success']) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Data berhasil diperbarui!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.of(context)
                                            .popAndPushNamed('/home');
                                      } else {
                                        setState(() {
                                          if (result!['errors'] != null) {
                                            // Map error ke field terkait
                                            _codeError = result['errors']
                                                    ['code_hewan']
                                                ?.first;
                                          }
                                        });

                                        // Validasi ulang form untuk menampilkan pesan error
                                        _formKey.currentState?.validate();

                                        // Tampilkan pesan error melalui SnackBar
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result!['message'] ??
                                                'Terjadi kesalahan'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                )
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
