import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  late MapController mapController;
  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initPosition: GeoPoint(
        latitude: 1.3331445,
        longitude: 103.774161,
      ), //Doesn't do anything (Main function at line 77)
      areaLimit: BoundingBox(east: 104.0, north: 1.5, south: 1.2, west: 103.6),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  } // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ngee Ann Polytechnic map'),
          backgroundColor: Colors.red,
        ),
        body: OSMFlutter(
          controller: mapController,
          osmOption: OSMOption(
            userTrackingOption: UserTrackingOption(
              enableTracking: false,
              unFollowUser: true,
            ),
            zoomOption: ZoomOption(
              initZoom: 8,
              minZoomLevel: 3,
              maxZoomLevel: 19,
              stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(Icons.double_arrow, size: 48),
              ),
            ),
            roadConfiguration: RoadOption(roadColor: Colors.yellowAccent),
          ),
          onMapIsReady: (isReady) async {
            if (isReady) {
              await mapController.setZoom(zoomLevel: 16.1);
              await mapController.moveTo(
                GeoPoint(latitude: 1.3331445, longitude: 103.774161),
              );
              await mapController.addMarker(
                GeoPoint(latitude: 1.33463, longitude: 103.77524),
                markerIcon: MarkerIcon(
                  icon: Icon(Icons.local_cafe, color: Colors.blue, size: 48),
                ),
              );
              await mapController.addMarker(
                GeoPoint(latitude: 1.33211, longitude: 103.77437),
                markerIcon: MarkerIcon(
                  icon: Icon(Icons.local_cafe, color: Colors.red, size: 48),
                ),
              );
              await mapController.addMarker(
                GeoPoint(latitude: 1.332303, longitude: 103.776413),
                markerIcon: MarkerIcon(
                  icon: Icon(Icons.local_cafe, color: Colors.pink, size: 48),
                ),
              );
            }
          },
          onGeoPointClicked: (GeoPoint point) async {
            await mapController.addMarker(
              point,
              markerIcon: MarkerIcon(
                icon: Icon(Icons.location_on, color: Colors.yellow, size: 48),
              ),
            );
          },
        ),
      ),
    );
  }
}
