import 'package:fanchip_mobile/components/button.dart';
import 'package:fanchip_mobile/screen/main_layout.dart';
import 'package:fanchip_mobile/model/hewan_model.dart';
import 'package:fanchip_mobile/services/hewan_service.dart';
import 'package:fanchip_mobile/services/lahir_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdatelahirPage extends StatefulWidget {
  const UpdatelahirPage({super.key});

  @override
  State<UpdatelahirPage> createState() => _UpdatelahirPageState();
}

class _UpdatelahirPageState extends State<UpdatelahirPage> {
  final _formKey = GlobalKey<FormState>();
  final _tglKawinController = TextEditingController();

  String? _selectedHewan;
  String? _estimasiLahir;
  String? _tglKawinToSend;
   String? _selectedHewanCode; 

  List<HewanModel> listHewan = [];
  String? _lahirId;

  final HewanService hewanService = HewanService();
  final LahirService lahirService = LahirService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as List<int>;
      if (args.isNotEmpty) {
        _lahirId = args.first.toString();
        getLahirData(_lahirId!);
      }
      getData();
    });
  }

  Future<void> getData() async {
    final data = await hewanService.getDataHewan();
    if (data != null) {
      setState(() {
        listHewan = data.toSet().toList(); // Menghapus duplikasi jika ada
        print(listHewan);
      });
    }
  }

  Future<void> getLahirData(String id) async {
    final lahirData = await lahirService.getDataLahirId(id);
    if (lahirData != null) {
      setState(() {
        _selectedHewan = lahirData.idHewan.toString();
        _selectedHewanCode = lahirData.codeHewan;
        print('Selected Hewan ID: $_selectedHewan');

        final originalDate = DateTime.parse(lahirData.tanggalLahir);
        final formattedDate =
            DateFormat('EEEE, dd MMMM yyyy').format(originalDate);

        _tglKawinController.text = formattedDate;

        final DateTime estimasiLahir =
            originalDate.add(const Duration(days: 150));
        _estimasiLahir = DateFormat('EEEE, dd MMMM yyyy').format(estimasiLahir);

        // Periksa apakah hewan sudah ada di daftar
        if (!listHewan
            .any((hewan) => hewan.id == lahirData.idHewan.toString())) {
          listHewan.add(HewanModel(
            id: lahirData.idHewan.toString(),
            nama: 'Nama Kambing Tidak Diketahui',
          ));
        }

        // Hapus duplikasi jika ada
        listHewan = listHewan.toSet().toList();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        _tglKawinController.text =
            DateFormat('EEEE, dd MMMM yyyy').format(selected);
        _tglKawinToSend = DateFormat('yyyy-MM-dd').format(selected);
        final DateTime estimasiLahir = selected.add(const Duration(days: 150));
        _estimasiLahir = DateFormat('EEEE, dd MMMM yyyy').format(estimasiLahir);
      });
    }
  }

  @override
  void dispose() {
    _tglKawinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kambing Lahiran'),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            value: listHewan
                                    .any((jenis) => jenis.id == _selectedHewan)
                                ? _selectedHewan
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Nama Kambing',
                              prefixIcon: const Icon(Icons.category),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: listHewan
                                .map(
                                  (hewan) => DropdownMenuItem<String>(
                                    value: hewan.id,
                                    child: Text(hewan.nama),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedHewan = value;
                                 _selectedHewanCode = listHewan
                                    .firstWhere((hewan) => hewan.id == value)
                                    .code_hewan; // Ganti `kode` dengan nama field yang sesuai
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pilih nama kambing';
                              }
                              return null;
                            },
                          ),
                          if (_selectedHewanCode != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.abc,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Code Kambing:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          _selectedHewanCode!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _tglKawinController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Tanggal Kawin',
                              labelText: 'Tanggal Kawin',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.date_range),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tanggal kawin wajib diisi';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          if (_estimasiLahir != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.event,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Estimasi Tanggal Lahir:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        _estimasiLahir!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          Button(
                            width: double.infinity,
                            title: "Submit",
                            disable: false,
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final result = await lahirService.postLahir(
                                  _selectedHewan!,
                                  _tglKawinToSend!,
                                );
                                if (result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Data berhasil ditambahkan!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainLayout(initialPage: 1),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Reservasi gagal!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
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
