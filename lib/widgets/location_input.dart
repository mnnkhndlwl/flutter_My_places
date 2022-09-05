import 'package:flutter/material.dart';
import '../helpers/location_helper.dart';
import 'package:location/location.dart';
import '../screens/map_screen.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String _previewImageUrl;

  // Future<void> _showPreview(double latitude, double longitude) async {
  //   final previewUrl = LocationHelper.generatePreview(
  //     latitude: latitude,
  //     longitude: longitude,
  //   );
  //   setState(() {
  //     _previewImageUrl = previewUrl;
  //   });
  // }

  // Future<void> _getCurrentUserLocation() async {
  //   final locData = await Location().getLocation();
  //   final staticMapImageUrl = LocationHelper.generatePreview(latitude: locData.latitude, longitude: locData.longitude);
  //   setState(() {
  //     _previewImageUrl = staticMapImageUrl;
  //   });
  // }

  // Future<void> _selectOnMap() async {
  //   final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
  //       builder: (ctx) => MapScreen(
  //             isSelecting: true,
  //           )));
  //   if(selectedLocation == null) {
  //     return;
  //   }
  //   print(selectedLocation);
  //    _showPreview(selectedLocation.latitude , selectedLocation.longitude);
  //    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  // }

  String _previewImageUrl;

  Future<void> _showPreview(double latitude, double longitude) async {
    final previewUrl = LocationHelper.generatePreview(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try{
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
        builder: (ctx) => MapScreen(
              isSelecting: true,
            )));
    if(selectedLocation == null) {
      return;
    }
    //print(selectedLocation);
    _showPreview(selectedLocation.latitude , selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),),
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
