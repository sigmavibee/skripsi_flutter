import 'package:flutter/material.dart';

import '../../../data/discussion/discussion_models.dart';
// import '../screen/comment_view.dart';

class DiscussionCard extends StatefulWidget {
  final Discussion discussionData;

  const DiscussionCard({
    Key? key,
    required this.discussionData,
  }) : super(key: key);

  @override
  State<DiscussionCard> createState() => _DiscussionCardState();
}

class _DiscussionCardState extends State<DiscussionCard> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.discussionData.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.discussionData.posterProfile),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.discussionData.posterUsername, style: const TextStyle(fontWeight: FontWeight.bold), ),
                    Container(
  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  decoration: BoxDecoration(
    color: widget.discussionData.posterRole == 'ADMIN'
        ? Colors.red.withOpacity(0.1)
        : widget.discussionData.posterRole == 'DOCTOR'
            ? Colors.green.withOpacity(0.1)
            : Colors.black.withOpacity(0.1),
    borderRadius: BorderRadius.circular(50),
  ),
  child: Text(
    widget.discussionData.posterRole,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      color: widget.discussionData.posterRole == 'ADMIN'
          ? Colors.red
          : widget.discussionData.posterRole == 'DOCTOR'
              ? Colors.green
              : Colors.black,
    ),
  ),
),
                    Text(widget.discussionData.createdAt.toIso8601String().split('T').first, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(widget.discussionData.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(widget.discussionData.postContent),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                  icon: Icon(Icons.thumb_up, color: _isLiked ? Colors.green : Colors.black54),
                  label: Text( widget.discussionData.likeCount.toString() , style: TextStyle(color: _isLiked ? Colors.green : Colors.black54)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(color: _isLiked ? Colors.green : Colors.transparent),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                      // MaterialPageRoute(
                      //   builder: (context) => CommentPage(discussion: widget.discussionData),
                      // ),
                    // );
                  },
                  icon: const Icon(Icons.comment, color: Colors.black54),
                  label: Text(widget.discussionData.commentCount.toString(), style: TextStyle(color: Colors.black54)),
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
