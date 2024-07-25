// consultation_view.dart
import 'package:flutter/material.dart';
import 'package:stunting_project/common/shared_widgets/bottom_nav_bar.dart';
import 'package:stunting_project/common/shared_widgets/custom_app_bar.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/data/consultation/consultation_models.dart';
import 'package:stunting_project/service/consultation_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  final ConsultationService _consultationService = ConsultationService();
  List<Consultation> _consultations = [];
  bool _isLoading = true;
  String? _errorMessage;
  final List<String> _routes = [
    '/',
    'article',
    'gizi',
    'discussion',
    'consultation',
  ];

  @override
  void initState() {
    super.initState();
    _fetchConsultations();
  }

  Future<void> _fetchConsultations() async {
    try {
      print('Fetching consultations...'); // Add this line
      List<Consultation> consultations =
          await _consultationService.getConsultations();
      print('Fetched consultations: ${consultations.length}'); // Add this line
      setState(() {
        _consultations = consultations;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching consultations: $e'); // Add this line
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        appBarTitle: 'Konsultasi',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : ListView.builder(
                  itemCount: _consultations.length,
                  itemBuilder: (context, index) {
                    return _buildCard(index);
                  },
                ),
      bottomNavigationBar: BottomNavBar(
        menuItems: [
          'Home',
          'Article',
          'Gizi',
          'Diskusi',
          'Konsultasi',
        ],
        currentIndex: 4,
        routes: _routes,
        onTap: (index) {
          Navigator.pushNamed(context, _routes[index]);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildCard(int index) {
    final consultation = _consultations[index];
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 10) {
          // Swipe right
          setState(() {
            _consultations.removeAt(index);
          });
        } else if (details.delta.dx < -10) {
          // Swipe left
          setState(() {
            _consultations.removeAt(index);
          });
        }
      },
      child: Transform.translate(
        offset: Offset(0, index * 10),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(consultation.consultantProfile),
            ),
            title: Text(consultation.consultantUsername),
            subtitle: Text(consultation.consultantDescription),
            trailing: InkWell(
              onTap: () {
                _openWhatsApp(consultation.consultantPhone);
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
      ),
    );
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    var whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      print("Could not launch $whatsappUrl");
    }
  }
}
