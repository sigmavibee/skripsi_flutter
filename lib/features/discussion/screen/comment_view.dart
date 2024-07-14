import 'package:flutter/material.dart';
import 'package:stunting_project/service/comment_service.dart';
import '../../../components/app_text_styles.dart';
import '../../../data/discussion/discussion_models.dart';
import '../../../data/discussion/comment_models.dart';
import '../../../data/discussion/commentrequest_models.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _currentUserId;
  String? _editingCommentId;
  bool _isEditing = false;
  List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    String? accessToken = await TokenManager.getAccessToken();
    if (accessToken != null) {
      _currentUserId = await TokenManager.getUserIdFromToken(accessToken);
      print('Current User ID: $_currentUserId');
    }
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
      } else {
        throw Exception('Invalid or expired token. Please login again.');
      }
    } catch (e) {}
  }

  void _createComment() async {
    String? accessToken = await TokenManager.getAccessToken();
    if (accessToken != null) {
      final postComment = _commentController.text.trim();

      // Pastikan komentar tidak kosong
      if (postComment.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Comment content cannot be empty.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Hentikan eksekusi jika komentar kosong
      }

      // Assuming _commentService is an instance of CommentService
      {
        bool success = await _commentService.createComment(
            widget.discussionData.id, postComment);
        if (success) {
          setState(() {
            _loadComments();
          });
          _commentController.clear();
        } else {}
      }
    }
  }

  void _updateComment() async {
    if (_formKey.currentState!.validate() && _editingCommentId != null) {
      String? accessToken = await TokenManager.getAccessToken();
      if (accessToken != null) {
        try {
          final postContent = _commentController.text;

          final updateRequest = CreateCommentRequest(
            commentContent: postContent,
          );

          final requestData = updateRequest.toJson();

          print('Updating Comment Data: $requestData');

          await _commentService.updateComment(_editingCommentId!, requestData);

          _loadComments();

          _commentController.clear();
          _editingCommentId = null;
          _isEditing = false;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Comment successfully updated')),
          );
        } catch (e) {
          print('Error updating comment: $e');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating comment: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Invalid or expired token. Please login again.')),
        );
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => true);
      }
    }
  }

  void _startEditingComment(Comment comment) {
    if (comment.commenterId == _currentUserId) {
      setState(() {
        _commentController.text = comment.commentContent;
        _editingCommentId =
            comment.id; // Ensure the correct comment ID is used here
        _isEditing = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only edit your own comment.')),
      );
      print(
          'Id : ${comment.id} PosterId : ${comment.commenterId} CurrentUserId : $_currentUserId');
    }
  }

  void _deleteComment(String commentId) async {
    String? accessToken = await TokenManager.getAccessToken();

    if (accessToken != null) {
      try {
        await _commentService.deleteComment(commentId);

        _loadComments();

        _commentController.clear();
        _editingCommentId = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Komentar berhasil dihapus')),
        );
      } catch (e) {
        print('Error deleting comment: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting comment: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Token tidak valid atau sudah kedaluwarsa. Silakan login kembali.'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komentar', style: AppTextStyle.heading4Bold),
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Text(timeago.format(
                                          widget.discussionData.createdAt)),
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
                        itemCount: _comments.isEmpty ? 1 : _comments.length,
                        itemBuilder: (context, index) {
                          if (_comments.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.comment, size: 64),
                                    const SizedBox(height: 8),
                                    Text('Belum ada komentar'),
                                    const SizedBox(height: 8),
                                    Text(
                                        'Jadilah yang pertama memberikan komentar!'),
                                  ],
                                ),
                              ),
                            );
                          } else {
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
                                              style: AppTextStyle.body2Bold,
                                            ),
                                            Text(
                                              timeago.format(comment.createdAt),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'update') {
                                              _startEditingComment(comment);
                                            } else if (value == 'delete') {
                                              _deleteComment(comment.id);
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
                          }
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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Comment cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_isEditing)
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateComment();
                        }
                      },
                      child: const Text('Update'),
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _createComment();
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
