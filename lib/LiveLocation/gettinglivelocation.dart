import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   MapboxMapController? _mapController;
   LocationData? _currentLocation;
  bool _trackingEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location Tracking'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MapboxMap(
              accessToken: 'pk.eyJ1IjoidmVudW1hbGxhY2hhcmkiLCJhIjoiY2xsZHZyNHExMGp0MzNlcDE3cHU0dGlqayJ9.1DfG1lq1qjYTGpXYfoczFw',
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0), // Default initial position
                zoom: 12.0,
              ),
              trackCameraPosition: true,
            ),
          ),
          SwitchListTile(
            title: Text('Enable Live Tracking'),
            value: _trackingEnabled,
            onChanged: _toggleTracking,
          ),
          if (_currentLocation != null)
            ListTile(
              title: Text('Current Location'),
              subtitle: Text(
                'Lat: ${_currentLocation?.latitude}\nLng: ${_currentLocation?.longitude}',
              ),
            ),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
  }

  void _toggleTracking(bool value) async {
    setState(() {
      _trackingEnabled = value;
    });

    if (_trackingEnabled) {
      _startLocationTracking();
    } else {
      _stopLocationTracking();
    }
  }

  void _startLocationTracking() async {
    var location = Location();
    location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _currentLocation = locationData;
        final _mapController = this._mapController;
        if (_mapController != null) {
          _mapController.animateCamera(CameraUpdate.newLatLng(
            LatLng(locationData.latitude!, locationData.longitude!),
          ));
        }
      });
    });
  }

  void _stopLocationTracking() {
    setState(() {
      _currentLocation = null;
    });
  }
}
