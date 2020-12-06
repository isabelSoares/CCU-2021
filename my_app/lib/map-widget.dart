import 'package:flutter/material.dart';
import 'package:my_app/custom-drawer-widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Map<MarkerId, Marker> markers = <MarkerId, Marker>{
  MarkerId('marker_id_1'): Marker(
      markerId: MarkerId('1'),
      position: LatLng(38.73754193759186, -9.153211002149378),
      infoWindow: InfoWindow(title: 'Biblioteca', snippet: '30%')),
  MarkerId('marker_id_2'): Marker(
      markerId: MarkerId('2'),
      position: LatLng(38.737316890280184, -9.153443665808037),
      infoWindow: InfoWindow(title: 'Restaurante', snippet: '50%')),
  MarkerId('marker_id_3'): Marker(
      markerId: MarkerId('3'),
      position: LatLng(38.73697816368897, -9.152690852595402),
      infoWindow: InfoWindow(title: 'Cafe', snippet: '40%')),
  MarkerId('marker_id_4'): Marker(
      markerId: MarkerId('4'),
      position: LatLng(38.736877563633065, -9.15316715580186),
      infoWindow: InfoWindow(title: 'Garden A', snippet: '10%')),
  MarkerId('marker_id_5'): Marker(
      markerId: MarkerId('5'),
      position: LatLng(38.737285934416136, -9.153734771050527),
      infoWindow: InfoWindow(title: 'Garden B', snippet: '30%')),
  MarkerId('marker_id_6'): Marker(
      markerId: MarkerId('6'),
      position: LatLng(38.737648237305706, -9.154895786661221),
      infoWindow: InfoWindow(title: 'Garden C', snippet: '60%'))
};

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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.5,
        ),
      ),
    );
  }
}
