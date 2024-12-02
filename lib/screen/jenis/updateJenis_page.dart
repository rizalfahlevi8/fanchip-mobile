import 'package:flutter/material.dart';
import 'package:fanchip_mobile/components/button.dart';
import 'package:fanchip_mobile/services/jenis_service.dart';

class UpdatejenisPage extends StatefulWidget {
  const UpdatejenisPage({super.key});

  @override
  State<UpdatejenisPage> createState() => _UpdatejenisPageState();
}

class _UpdatejenisPageState extends State<UpdatejenisPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String? _jenisId;

  final JenisService jenisService = JenisService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
      print(args.first);
      if (args.isNotEmpty) {
        _jenisId = args.first;
        getJenisData(_jenisId!);
      }
    });
  }

  Future<void> getJenisData(String id) async {
    final jenisData = await jenisService.getDataJenisId(id);
    if (jenisData != null) {
      setState(() {
        _nameController.text = jenisData.nama ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Jenis Kambing'),
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
                            'Edit Data Jenis Kambing',
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
                                    hintText: 'Nama Jenis Kambing',
                                    labelText: 'Nama Jenis Kambing',
                                    prefixIcon: const Icon(Icons.pets),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama Jenis Kambing wajib diisi';
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
                                      if (_formKey.currentState!.validate()) {
                                        bool result =
                                            await jenisService.updateJenis(
                                                _jenisId!,
                                                _nameController.text);

                                        if (result) {
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Pembaruan data gagal!'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
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
