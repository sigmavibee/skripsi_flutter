import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});
  
  get discussion => null;
  get comments => null;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Komentar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              
            ) 
          )
        ]));}}