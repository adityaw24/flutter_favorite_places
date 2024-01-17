import 'package:flutter/material.dart';
import 'package:flutter_favorite_places/providers/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_favorite_places/screens/add_place.dart';
import 'package:flutter_favorite_places/widgets/place_list.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  void _addPlace({
    required BuildContext context,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const AddPlaceScreen(),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refPlace = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              _addPlace(context: context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: PlacesList(
          places: refPlace,
        ),
      ),
    );
  }
}
