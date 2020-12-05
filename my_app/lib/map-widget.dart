import 'package:flutter/material.dart';
import 'package:my_app/custom-drawer-widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  MapWidget();

  GoogleMapController mapController;

    final LatLng _center = const LatLng(38.73622228023147, -9.15344638918027);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      drawer: CustomDrawerWidget(),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.5,
          ),
        ),
    );
  }
}
