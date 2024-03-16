import 'package:flutter/material.dart';

import '../common/validators.dart';

class CreateAlbumDialog extends StatefulWidget {
  const CreateAlbumDialog({super.key});

  @override
  State<CreateAlbumDialog> createState() => _CreateAlbumDialogState();
}

class _CreateAlbumDialogState extends State<CreateAlbumDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: const Text('Create New Album'),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                validator: textNotBlankValidator,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Dismiss'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(_titleController.text);
                    }
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
        ],
      );
}
