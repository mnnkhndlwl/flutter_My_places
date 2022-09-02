import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: const Text('Got no places yet!'),
        ),
        builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
            ? ch
            : ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatPlaces.items[index].image,
                    ),
                  ),
                  title: Text(greatPlaces.items[index].title),
                  onTap: () {
                    
                  },
                ),
                itemCount: greatPlaces.items.length,
              ),
      ),
    );
  }
}
