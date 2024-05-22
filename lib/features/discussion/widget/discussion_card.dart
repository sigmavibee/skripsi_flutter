import 'package:flutter/material.dart';

class DiscussionCard extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String postedTime;
  final String discussionTitle;
  final String discussionReply;

  const DiscussionCard({
    Key? key,
    required this.profileImageUrl,
    required this.username,
    required this.postedTime,
    required this.discussionTitle,
    required this.discussionReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( 'santi'
                      // username, style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    Text('a week ago'
                      // postedTime, style: TextStyle(color: Colors.grey, fontSize: 12)
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(discussionTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(discussionReply),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up, color: Colors.black54),
                  label: const Text('Like', style: TextStyle(color: Colors.black54)),
                  style: ElevatedButton.styleFrom(
                  
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment, color: Colors.black54),
                  label: const Text('Comment', style: const TextStyle(color: Colors.black54)),
                  style: ElevatedButton.styleFrom(
                
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}