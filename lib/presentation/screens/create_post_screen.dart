// lib/presentation/screens/create_post_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_sync/common/buttons/dynamic_button.dart';
import 'package:user_sync/data/models/post_model.dart';
import 'package:user_sync/data/models/user_model.dart';

import '../blocs/user_detail/user_detail_bloc.dart';
import '../blocs/user_detail/user_detail_event.dart';

class CreatePostScreen extends StatefulWidget {
  final User user; // Add user parameter

  const CreatePostScreen({super.key, required this.user});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch, // Temporary unique ID
        title: _titleController.text,
        body: _bodyController.text,
      );

      // Access the bloc from context
      final userDetailBloc = context.read<UserDetailBloc>();
      userDetailBloc.add(AddPost(newPost));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post for ${widget.user.firstName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Show user info at the top
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.user.image),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Creating post for ${widget.user.firstName} ${widget.user.lastName}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Body',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a body';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DynamicButton.fromText(
                  text: "Submit Post",
                  onPressed: _submitPost,
                ),
                // ElevatedButton(
                //   onPressed: _submitPost,
                //   child: const Text('Submit Post'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
