import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_favorite_places/providers/places.dart';
import 'package:flutter_favorite_places/widgets/image_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  bool _isSubmit = false;
  final _titleController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;

    setState(() {
      _isSubmit = true;
    });

    if (enteredTitle == '' || enteredTitle.isEmpty || _selectedImage == null) {
      setState(() {
        _isSubmit = false;
      });
      return;
    }

    ref.read(placesProvider.notifier).addPlace(enteredTitle, _selectedImage!);

    setState(() {
      _isSubmit = false;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ImageInput(onPickImage: (image) {
                _selectedImage = image;
              }),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _isSubmit
                        ? null
                        : () {
                            _savePlace();
                          },
                    label: const Text('Add Place'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
