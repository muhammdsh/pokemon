import 'package:base_structure/presentation/custom_widgets/infinite_list_view/model.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({key,required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}