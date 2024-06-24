import 'package:flutter/material.dart';
import 'package:stunting_project/data/discussion/discussion_models.dart';
import 'package:stunting_project/features/discussion/widget/discussion_card.dart';
import 'package:stunting_project/service/discussion_service.dart';
import 'package:stunting_project/tokenmanager.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final DiscussionService _discussionService = DiscussionService();
  late Future<List<Discussion>> _futureDiscussions;

  @override
  void initState() {
    super.initState();
    _loadDiscussions();
  }
  

  void _loadDiscussions() async {
  String? accessToken = await TokenManager.getAccessToken();
  print('Access Token: $accessToken'); // Logging token retrieval

  if (accessToken != null) {
    try {
      setState(() {
        _futureDiscussions = _discussionService.getDiscussions();
      });
    } catch (e) {
      print('Error loading discussions: $e'); // Logging error if any
      setState(() {
        _futureDiscussions = Future.error('Error loading discussions: $e');
      });
    }
  } else {
    print('Invalid or expired token. Please login again.');
    setState(() {
      _futureDiscussions = Future.error('Invalid or expired token. Please login again.');
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discussion',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Discussion Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    // Handle text field changes
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Your Question/Comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    // Handle text field changes
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: const Text('Send'),
              ),
              const SizedBox(height: 15),
              const Text(
                'Discussion List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<Discussion>>(
                future: _futureDiscussions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No discussions found.');
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final discussion = snapshot.data![index];
                        return DiscussionCard(discussionData: discussion);
                      },
                      separatorBuilder: (context, index) => Divider(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
