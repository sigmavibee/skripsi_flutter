import 'package:flutter/material.dart';
import 'package:stunting_project/service/comment_service.dart';
import '../../../components/app_text_styles.dart';
import '../../../data/discussion/discussion_models.dart';
import '../../../data/discussion/comment_models.dart';
import '../../../tokenmanager.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentPage extends StatefulWidget {
  final Discussion discussionData;

  const CommentPage({
    Key? key,
    required this.discussionData,
  }) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  final CommentService _commentService = CommentService();
  List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      String? accessToken = await TokenManager.getAccessToken();
      if (accessToken != null) {
        final comments =
            await _commentService.getComments(widget.discussionData.id);
        setState(() {
          _comments = comments ?? [];
        });
        print('Comments updated: ${_comments.length}');
      } else {
        print('Invalid or expired token. Please login again.');
        throw Exception('Invalid or expired token. Please login again.');
      }
    } catch (e) {
      print('Error loading comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komentar', style: AppTextStyle.heading4Bold),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.discussionData.posterProfile),
                                  radius: 20,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.discussionData.posterUsername
                                                  .length >
                                              20
                                          ? '${widget.discussionData.posterUsername.substring(0, 20)}...'
                                          : widget
                                              .discussionData.posterUsername,
                                      style: AppTextStyle.body2Bold,
                                    ),
                                    Text(
                                      timeago.format(
                                          widget.discussionData.createdAt),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(widget.discussionData.title,
                                style: AppTextStyle.heading5Bold),
                            const SizedBox(height: 10),
                            Text(widget.discussionData.postContent),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Semua Komentar',
                        style: AppTextStyle.heading5Bold),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          comment.commenterProfile),
                                      radius: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            comment.commenterUsername.length >
                                                    20
                                                ? '${comment.commenterUsername.substring(0, 20)}...'
                                                : comment.commenterUsername,
                                            style: AppTextStyle.body2Bold),
                                        Text(
                                          comment.createdAt
                                              .toIso8601String()
                                              .split('T')
                                              .first,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'update') {
                                          // widget .onStartEditing(); // Call _startEditingDiscussion callback
                                        } else if (value == 'delete') {
                                          // widget.onStartDeleting();
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
                                const SizedBox(height: 10),
                                Text(comment.commentContent),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Implement your send comment functionality here
                    // e.g., sendComment(_commentController.text);
                    _commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
