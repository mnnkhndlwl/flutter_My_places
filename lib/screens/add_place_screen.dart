import 'package:flutter/material.dart';
import '../widgets/location_input.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();

  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savedPlace() {
    if(_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addPlace( _titleController.text, _pickedImage,_pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(height: 10,),
                  ImageInput(_selectImage),
                  SizedBox(height: 10,),
                  LocationInput(_selectPlace)
                ],),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savedPlace,
            icon: Icon(Icons.add),
            label: Text('Add place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
