import 'package:fanchip_mobile/components/button.dart';
import 'package:fanchip_mobile/model/jenis_model.dart';
import 'package:fanchip_mobile/services/jenis_service.dart';
import 'package:flutter/material.dart';

class CreatejenisPage extends StatefulWidget {
  const CreatejenisPage({super.key});

  @override
  State<CreatejenisPage> createState() => _CreatejenisPageState();
}

class _CreatejenisPageState extends State<CreatejenisPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  List<JenisModel> listJenis = [];

  final JenisService jenisService = JenisService();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Jenis Kambing'),
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
                                    title: "Submit",
                                    disable: false,
                                    onPressed: () async {
                                      final result =
                                          await jenisService.postHewan(
                                              _nameController.text,);

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
