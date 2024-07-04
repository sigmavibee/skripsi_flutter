import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';

import '../../../data/discussion/discussion_models.dart';
import '../screen/comment_view.dart';

class DiscussionCard extends StatefulWidget {
  final Discussion discussionData;
  final VoidCallback onStartEditing;
  final VoidCallback onStartDeleting;
  final VoidCallback onLike;
  final VoidCallback onUnlike;

  const DiscussionCard({
    Key? key,
    required this.discussionData,
    required this.onStartEditing,
    required this.onStartDeleting,
    required this.onLike,
    required this.onUnlike,
  }) : super(key: key);

  @override
  State<DiscussionCard> createState() => _DiscussionCardState();
}

class _DiscussionCardState extends State<DiscussionCard> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Profile section
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.discussionData.posterProfile),
                      radius: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.discussionData.posterUsername.length > 20
                              ? '${widget.discussionData.posterUsername.substring(0, 20)}...'
                              : widget.discussionData.posterUsername,
                          style: AppTextStyle.body2Bold,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color:
                                _getRoleColor(widget.discussionData.posterRole),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            widget.discussionData.posterRole,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(
                            widget.discussionData.createdAt
                                .toIso8601String()
                                .split('T')
                                .first,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                // Menu dropdown section
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'update') {
                      widget
                          .onStartEditing(); // Call _startEditingDiscussion callback
                    } else if (value == 'delete') {
                      widget.onStartDeleting();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'update',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Update'),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(widget.discussionData.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(widget.discussionData.postContent),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: widget.discussionData.isLiked
                      ? widget.onUnlike
                      : widget.onLike,
                  icon: Icon(
                    widget.discussionData.isLiked
                        ? Icons.thumb_up
                        : Icons.thumb_up_off_alt,
                    color: widget.discussionData.isLiked
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  label: Text(
                    widget.discussionData.likeCount.toString(),
                    style: TextStyle(
                      color: widget.discussionData.isLiked
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      color: widget.discussionData.isLiked
                          ? Colors.blue
                          : Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(
                          discussionData: widget.discussionData,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.comment, color: Colors.black54),
                  label: Text(widget.discussionData.commentCount.toString(),
                      style: TextStyle(color: Colors.black54)),
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

  Color _getRoleColor(String role) {
    switch (role) {
      case 'ADMIN':
        return Colors.red.withOpacity(0.5);
      case 'DOCTOR':
        return Colors.green.withOpacity(0.5);
      default:
        return Colors.blue.withOpacity(0.5);
    }
  }
}
