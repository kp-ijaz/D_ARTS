// import 'dart:developer';

// import 'package:d_art/application/controller/map_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // import '../../controller/map_controller/gmap_controller.dart';

// class GMapPage extends StatelessWidget {
//   GMapPage({super.key});
//   final GMapController cntrl = Get.put(GMapController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: GetX<GMapController>(
//               builder: (controller) {
//                 LatLng? position = controller.latLng.value;
//                 log('pinneyu build ayi');
//                 return GoogleMap(
//                   onTap: (argument) {
//                     // controller.onClickedLocation(argument);

//                     controller.updateMarkers(argument);
//                   },
//                   initialCameraPosition:
//                       // position !=  const LatLng(11.258753, 75.780411)
//                       //     ? CameraPosition(target: position, zoom: 14)
//                       //     :
//                       const CameraPosition(
//                           target: LatLng(12.44, 20.445), zoom: 14),
//                   mapType: MapType.normal,
//                   onMapCreated: (controllerofmap) {
//                     controller.mapController = controllerofmap;
//                     if (position != const LatLng(11.258753, 75.780411)) {
//                       controller.mapController!.animateCamera(
//                         CameraUpdate.newCameraPosition(
//                           CameraPosition(target: position, zoom: 14),
//                         ),
//                       );

//                       controller.markers.clear();
//                       controller.markers.add(
//                         Marker(
//                           markerId: const MarkerId('Current position'),
//                           position: position,
//                         ),
//                       );
//                       // controller.updateMarkers();
//                     }
//                   },
//                   markers: controller.markers,
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await cntrl.oncurrentClickedLocation();
//                 },
//                 child: const Text('Current Location'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
