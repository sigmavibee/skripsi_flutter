import 'package:flutter/material.dart';
import 'package:stunting_project/data/discussion/discussion_models.dart';
import 'package:stunting_project/features/discussion/widget/discussion_card.dart';
import 'package:stunting_project/service/discussion_service.dart';
import 'package:stunting_project/tokenmanager.dart';

import '../../../data/discussion/discussionrequest_models.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final DiscussionService _discussionService = DiscussionService();
  late Future<List<Discussion>> _futureDiscussions;
  final _formKey = GlobalKey<FormState>();
  String? _editingDiscussionId;
  String? _currentUserId;
  bool _isEditing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _loadCurrentUser();
    _loadDiscussions();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _loadDiscussions();
    }
  }

  Future<void> _loadCurrentUser() async {
    String? accessToken = await TokenManager.getAccessToken();
    if (accessToken != null) {
      _currentUserId = await TokenManager.getUserIdFromToken(accessToken);
      print('Current User ID: $_currentUserId');
    }
  }

  Future<void> _loadDiscussions() async {
    setState(() {
      _futureDiscussions = _fetchDiscussions();
    });
  }

  Future<List<Discussion>> _fetchDiscussions() async {
    String? accessToken = await TokenManager.getAccessToken();
    print('Access Token: $accessToken'); // Logging token retrieval

    if (accessToken != null) {
      try {
        return await _discussionService.getDiscussions();
      } catch (e) {
        throw Exception('Error loading discussions: $e');
      }
    } else {
      throw Exception('Invalid or expired token. Please login again.');
    }
  }

  void _createDiscussion() async {
    if (_formKey.currentState!.validate()) {
      String? accessToken = await TokenManager.getAccessToken();
      if (accessToken != null) {
        try {
          final title = _titleController.text;
          final postContent = _contentController.text;

          final createRequest = CreateDiscussionRequest(
            title: title,
            postContent: postContent,
          );

          // Convert to JSON
          final requestData = createRequest.toJson();

          // Print the data being sent to the server
          print('New Discussion Data: $requestData');

          await _discussionService.createDiscussion(requestData);

          _loadDiscussions();

          _titleController.clear();
          _contentController.clear();
        } catch (e) {
          print('Error creating discussion: ${e.toString()}');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Gagal membuat diskusi ${e.toString()}'),
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
        }
      }
    }
  }

  void _updateDiscussion() async {
    if (_formKey.currentState!.validate() && _editingDiscussionId != null) {
      String? accessToken = await TokenManager.getAccessToken();
      if (accessToken != null) {
        try {
          final title = _titleController.text;
          final postContent = _contentController.text;

          final updateRequest = CreateDiscussionRequest(
            title: title,
            postContent: postContent,
          );

          final requestData = updateRequest.toJson();

          print('Updating Discussion Data: $requestData');

          await _discussionService.updateDiscussion(
              _editingDiscussionId!, requestData);

          _loadDiscussions();

          _titleController.clear();
          _contentController.clear();
          _editingDiscussionId = null;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Discussion successfully updated')),
          );
        } catch (e) {
          print('Error updating discussion: $e');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating discussion: $e')),
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

  void _deleteDiscussion(String discussionId) async {
    String? accessToken = await TokenManager.getAccessToken();
    if (accessToken != null) {
      try {
        await _discussionService.deleteDiscussion(discussionId);

        _loadDiscussions();

        _titleController.clear();
        _contentController.clear();
        _editingDiscussionId = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Discussion successfully deleted')),
        );
      } catch (e) {
        print('Error deleting discussion: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting discussion: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid or expired token. Please login again.'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => true);
    }
  }

  void _startEditingDiscussion(Discussion discussion) {
    if (discussion.posterId == _currentUserId) {
      setState(() {
        _titleController.text = discussion.title;
        _contentController.text = discussion.postContent;
        _editingDiscussionId = discussion.id;
        _isEditing = true; // Set to true when editing starts
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only edit your own discussions.')),
      );
      print(
          'Id : ${discussion.id} PosterId : ${discussion.posterId} CurrentUserId : $_currentUserId');
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _editingDiscussionId = null;
      _titleController.clear();
      _contentController.clear();
    });
  }

  void _startDeletingDiscussion(Discussion discussion) {
    if (discussion.posterId == _currentUserId) {
      setState(() {
        _titleController.text = discussion.title;
        _contentController.text = discussion.postContent;
        _editingDiscussionId = discussion.id;
      });
      _deleteDiscussion(discussion.id); // Pass discussion id to delete
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only delete your own discussions.')),
      );
    }
  }

  void _likeDiscussion(Discussion discussion) async {
    try {
      await _discussionService.likeDiscussion(discussion.id);
      setState(() {
        discussion.isLiked = true;
        discussion.likeCount++;
      });
    } catch (e) {
      print('Error liking discussion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error liking discussion: $e')),
      );
    }
  }

  void _unlikeDiscussion(Discussion discussion) async {
    try {
      await _discussionService.unlikeDiscussion(discussion.id);
      setState(() {
        discussion.isLiked = false;
        discussion.likeCount--;
      });
    } catch (e) {
      print('Error unliking discussion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error unliking discussion: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _loadDiscussions();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discussion',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Judul Diskusi',
                        border: OutlineInputBorder(),
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Isi Konten tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Pertanyaan atau Komentar Anda',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      controller: _contentController,
                    ),
                    const SizedBox(height: 8.0),
                    if (_isEditing) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _updateDiscussion,
                            child: const Text('Update'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: _cancelEditing,
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ] else
                      ElevatedButton(
                        onPressed: _createDiscussion,
                        child: const Text('Send'),
                      ),
                    const SizedBox(height: 5),
                    const Text(
                      'Discussion List',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Discussion>>(
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final discussion = snapshot.data![index];
                          return DiscussionCard(
                            discussionData: discussion,
                            onStartEditing: () =>
                                _startEditingDiscussion(discussion),
                            onStartDeleting: () =>
                                _startDeletingDiscussion(discussion),
                            onLike: () => _likeDiscussion(discussion),
                            onUnlike: () => _unlikeDiscussion(discussion),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
