import 'dart:io';

import 'package:favourite_place/providers/favourite_place_provider.dart';
import 'package:favourite_place/widgets/camera_input.dart';
import 'package:favourite_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddplaceScreen extends ConsumerStatefulWidget {
  const AddplaceScreen({super.key});

  @override
  ConsumerState<AddplaceScreen> createState() => _AddplaceScreenState();
}

class _AddplaceScreenState extends ConsumerState<AddplaceScreen> {
  final _formkey = GlobalKey<FormState>();
  var _placetitle = "";
  File? _selectedimage;
  void _onadditem() {
    _formkey.currentState!.validate();
    _formkey.currentState!.save();
    ref
        .read(favouritePlaceProvider.notifier)
        .addfavouriteplace(_placetitle, _selectedimage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a place")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Title")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "enter Some name";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _placetitle = value!;
                    },
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CamreInput(
                    onpickimage: (image) {
                      _selectedimage = image;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                 const  LocationInput(),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                    onPressed: _onadditem,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Place'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
