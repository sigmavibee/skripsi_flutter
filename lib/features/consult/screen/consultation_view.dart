import 'package:flutter/material.dart';

class ConsultationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi'),
      ),
      body: ListView.builder(
        itemCount: 5, // Jumlah card konsultasi
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(index.toString()), // Key unik untuk setiap card
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            onDismissed: (direction) {
              // Tangani aksi swipe
            },
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                title: Text('Nama Konsultan $index'),
                subtitle: Text('Role Konsultan'),
                trailing: InkWell(
                  // onTap: () {
                  //   _openWhatsApp('+123456789'); // Nomor handphone untuk WhatsApp
                  // },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
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

//   void _openWhatsApp(String phoneNumber) async {
//     // Membuka aplikasi WhatsApp dengan nomor handphone tertentu
//     var whatsappUrl = "whatsapp://send?phone=$phoneNumber";
//     await canLaunch(whatsappUrl)
//         ? launch(whatsappUrl)
//         : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('WhatsApp tidak terpasang di perangkat ini.')));
//   }
}
