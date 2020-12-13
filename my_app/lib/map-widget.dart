import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class MapWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();
  GoogleMapController mapController;
  final LatLng _center = const LatLng(38.73622228023147, -9.15344638918027);

  MapWidget();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> places = [];

    return Scaffold(
      body: StreamBuilder(
        stream: databaseReference.child("places/").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            values.forEach((key, value) {
              if (key == "gardens") {
                Map<dynamic, dynamic>.from(value).forEach((key, value) {
                  places.add(value);
                });
              } else {
                places.add(value);
              }
            });

            Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
            for (int i = 0; i < places.length; i++) {
              markers[MarkerId('marker_id_' + i.toString())] = Marker(
                markerId: MarkerId(i.toString()),
                position: LatLng(places[i]["latitude"], places[i]["longitude"]),
                infoWindow: InfoWindow(
                  title: places[i]["name"],
                  snippet: places[i]["capacity"].toString() + " %",
                ),
              );
            }

            return GoogleMap(
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.5,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
