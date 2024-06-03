import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:intl/intl.dart';

class GiziPage extends StatefulWidget {
  GiziPage({Key? key}) : super(key: key);

  @override
  State<GiziPage> createState() => _GiziPageState();
}

class _GiziPageState extends State<GiziPage> {
  final TextEditingController dateController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();
  
  String _gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Gizi Balita', style: AppTextStyle.heading4Bold),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 0);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, 'gizihistory');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nama Balita'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Balita tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      String formattedDate = formatter.format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal Lahir tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Jenis Kelamin:'),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Laki-laki',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        const Text('Laki-laki'),
                        Radio<String>(
                          value: 'Perempuan',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        const Text('Perempuan'),
                      ],
                    ),
                  ],
                ),
                if (_gender.isEmpty) 
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Jenis Kelamin tidak boleh kosong',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tinggi Badan (cm)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tinggi Badan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Berat Badan (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat Badan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _gender.isNotEmpty) {
                      // Handle submit button
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data berhasil disimpan')),
                      );
                    } else if (_gender.isEmpty) {
                      setState(() {});  // Trigger rebuild to show gender error
                    }
                  },
                  child: const Text('Simpan'),
              
                ),SizedBox(height: 16,),Text('Kategori BMI :', style: AppTextStyle.body2Medium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
