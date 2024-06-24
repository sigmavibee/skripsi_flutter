// import 'package:flutter/material.dart';
// import '../../../components/app_text_styles.dart';
// import '../../../data/discussion/discussion_models.dart';


// class CommentPage extends StatefulWidget {
//   final Discussion discussion;
  

//   const CommentPage({Key? key, required this.discussion}) : super(key: key);

//   @override
//   State<CommentPage> createState() => _CommentPageState();
// }

// class _CommentPageState extends State<CommentPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Komentar', style: AppTextStyle.heading4Bold),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: NetworkImage(widget.discussion.profileImageUrl),
//                             radius: 20,
//                           ),
//                           const SizedBox(width: 10),
//                           Text(widget.discussion.username, style: AppTextStyle.heading5Bold),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Text(widget.discussion.discussionTitle, style: AppTextStyle.heading5Bold),
//                       const SizedBox(height: 10),
//                       Text(widget.discussion.discussionReply),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               Text('Comments', style: AppTextStyle.heading5Bold),
//               ListView.separated(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: widget.discussion.comment.length,
//                 itemBuilder: (context, index) {
//                   final comment = widget.discussion.comment[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundImage: NetworkImage(comment.profileImageUrl),
//                                 radius: 20,
//                               ),
//                               SizedBox(width: 10),
//                               Text(comment.name, style: AppTextStyle.heading5Bold),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Text(comment.content),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => Divider(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
