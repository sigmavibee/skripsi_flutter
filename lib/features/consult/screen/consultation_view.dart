import 'package:flutter/material.dart';

import 'package:stunting_project/data/consultation/consultation_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationPage extends StatefulWidget {
  final List<Consultation> consultationData;

  const ConsultationPage({
    Key? key,
    required this.consultationData,
  }) : super(key: key);

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konsultasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 0);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.consultationData.length, // Jumlah card konsultasi
        itemBuilder: (BuildContext context, int index) {
          final consultation = widget.consultationData[index];
          return Dismissible(
            key: Key(index.toString()), // Key unik untuk setiap card
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                widget.consultationData.removeAt(index);
              });
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(consultation.imageUrl),
                ),
                title: Text(consultation.consultantName),
                subtitle: const Text('Role Konsultan'),
                trailing: InkWell(
                  onTap: () {
                    _openWhatsApp(consultation.phoneNumber); // Nomor handphone untuk WhatsApp
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.message, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Hubungi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

 Future<void> _openWhatsApp(String phoneNumber) async {
  var whatsappUrl = "https://wa.me/$phoneNumber";

  // Check if the URL can be launched
  if (await canLaunch(whatsappUrl)) {
    // Launch the URL
    await launch(whatsappUrl);
  } else {
    // Let the user know if the URL cannot be launched
    print("Could not launch $whatsappUrl");
  }
}}