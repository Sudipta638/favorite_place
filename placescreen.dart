import 'package:favourite_place/providers/favourite_place_provider.dart';
import 'package:favourite_place/screen/addplacescreen.dart';
import 'package:favourite_place/widgets/places_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceScreen extends ConsumerStatefulWidget {
  const PlaceScreen({super.key});
  @override
  ConsumerState<PlaceScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlaceScreen> {
  late Future<void> _placesfuture;

  @override
  void initState() {
    super.initState();
    _placesfuture = ref.watch(favouritePlaceProvider.notifier).loadplaces();
  }

  void _onaddplace(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddplaceScreen()));
  }

  // void _viewplace(String title,BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (ctx) => PlaceDetails(
  //             title: title,
  //           )));
  // }

  @override
  Widget build(BuildContext context) {
    final favouiteplaces = ref.watch(favouritePlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Place"),
        actions: [
          IconButton(
              onPressed: () {
                _onaddplace(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesfuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesList(places: favouiteplaces),
        ),
      ),
    );
  }
}
