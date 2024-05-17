import 'package:flutter/material.dart';
import 'package:stunting_project/features/discussion/widget/discussion_card.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  String _discussionTitle = '';
  String _discussionContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Discussion Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _discussionTitle = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Question/Comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    _discussionContent = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle sending the discussion content
                  _sendDiscussionContent();
                },
                child: Text('Send'),
              ),SizedBox(height: 15,),
              DiscussionCard(profileImageUrl: 'assets/profile.jpg', username: 'username', postedTime: 'postedTime', discussionTitle: 'discussionTitle', discussionReply: 'discussionReply'),
              DiscussionCard(profileImageUrl: 'assets/profile.jpg', username: 'username', postedTime: 'postedTime', discussionTitle: 'discussionTitle', discussionReply: 'discussionReply'),
              DiscussionCard(profileImageUrl: 'assets/profile.jpg', username: 'username', postedTime: 'postedTime', discussionTitle: 'discussionTitle', discussionReply: 'discussionReply'),
              DiscussionCard(profileImageUrl: 'assets/profile.jpg', username: 'username', postedTime: 'postedTime', discussionTitle: 'discussionTitle', discussionReply: 'discussionReply')
            ],
          ),
        ),
      ),
    );
  }

  

  void _sendDiscussionContent() {
    // Implement sending logic here (e.g., send API request, update database, etc.)
    print('Discussion Title: $_discussionTitle');
    print('Discussion Content: $_discussionContent');
    // Show a snackbar or dialog to indicate success or failure
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Discussion content sent!'),
      ),
    );
    // Clear the text fields after sending
    setState(() {
      _discussionTitle = '';
      _discussionContent = '';
    });
  }
}
