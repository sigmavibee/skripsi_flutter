import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stunting_project/components/app_text_styles.dart';


import 'package:stunting_project/data/discussion/discussion_list.dart';
import 'package:stunting_project/features/discussion/widget/discussion_card.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion',style: AppTextStyle.heading4Bold,),
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
              const SizedBox(height: 15,),
              const Text('Discussion List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              itemCount: discussionData.length,
              itemBuilder: (context, index) {
                final discussion = discussionData[index];
                return DiscussionCard(discussionData: discussion,);
              },
              separatorBuilder: (context, index) => Divider(),
            )
            ],
          ),
        ),
      ),
    );
  }
}

