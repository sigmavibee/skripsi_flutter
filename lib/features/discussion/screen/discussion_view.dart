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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureDiscussions = _loadDiscussions(); // Initialize with a default value
  }

  Future<List<Discussion>> _loadDiscussions() async {
    String? accessToken = await TokenManager.getAccessToken();
    print('Access Token: $accessToken'); // Logging token retrieval

    if (accessToken != null) {
      try {
        return await _discussionService.getDiscussions();
      } catch (e) {
        print('Error loading discussions: $e'); // Logging error if any
        throw Exception('Error loading discussions: $e');
      }
    } else {
      print('Invalid or expired token. Please login again.');
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

          final createdDiscussion =
              await _discussionService.createDiscussion(requestData);

          setState(() {
            _futureDiscussions = _loadDiscussions();
          });

          _titleController.clear();
          _contentController.clear();
        } catch (e) {
          print('Error creating discussion: ${e.toString()}');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Failed to create discussion: ${e.toString()}'),
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

          setState(() {
            _futureDiscussions = _loadDiscussions();
          });

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
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      }
    }
  }

  void _startEditingDiscussion(Discussion discussion) {
    setState(() {
      _titleController.text = discussion.title;
      _contentController.text = discussion.postContent;
      _editingDiscussionId = discussion.id;
    });
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
          child: Form(
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _createDiscussion,
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
      ),
    );
  }
}
