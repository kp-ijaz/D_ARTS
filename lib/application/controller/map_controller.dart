// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GMapController extends GetxController {
//   RxSet<Marker> markers = <Marker>{}.obs;
//   Rx<LatLng> latLng = const LatLng(11.258753, 75.780411).obs;
//   GoogleMapController? mapController;

// // ======================================================
// // to get current location
// // -------------------------------------------------------

//   Future<void> oncurrentClickedLocation() async {
//     log("onClickedLocation");
//     LatLng position = await getLocationUpdates();
//     log("printing postion that are being listed 2222 before assigning the value ${position.toString()}");
//     latLng.value = position;
//     markers.clear();
//     markers.add(
//       Marker(
//         markerId: const MarkerId('current Location'),
//         position: LatLng(position.latitude, position.longitude),
//       ),
//     );

//     mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: position, zoom: 14),
//       ),
//     );
//     // gfun(position);
//   }

//   Future<LatLng> getLocationUpdates() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       log('Location service is disabled');
//       Get.showSnackbar(const GetSnackBar(
//         message: 'Location service is disabled',
//         snackStyle: SnackStyle.FLOATING,
//         backgroundColor: Colors.red,
//         dismissDirection: DismissDirection.horizontal,
//         forwardAnimationCurve: Curves.bounceInOut,
//       ));
//       return Future.error('Location service is disabled');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       await Geolocator.requestPermission();
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         log('Location permission is denied');
//         Get.showSnackbar(const GetSnackBar(
//           message: 'Location permission is denied',
//           snackStyle: SnackStyle.FLOATING,
//           backgroundColor: Colors.red,
//           dismissDirection: DismissDirection.horizontal,
//           forwardAnimationCurve: Curves.bounceInOut,
//         ));
//         return Future.error('Location permission is denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       log('Location permission denied permenently');

//       return Future.error('Location permission denied permenently');
//     }
//     var currentPostion = await Geolocator.getCurrentPosition();

//     return LatLng(currentPostion.latitude, currentPostion.longitude);
//   }

// // ======================================================
// // to update location on marker sslected basis
// // -------------------------------------------------------

//   void updateMarkers(LatLng latitudelong) {
//     log('log enter into update marke');
//     latLng.value = latitudelong;
//     markers.clear();
//     markers.add(
//       Marker(
//           markerId: const MarkerId('current position'), position: latLng.value),
//     );

//     log('log eended');
//     update();
//   }

// // ======================================================
// // to clear and get current location {Current loc helper}
// // -------------------------------------------------------

//   // void gfun(LatLng position) {
//   //   log('markers in GMapController ${markers.toString()}');
//   //   log('markers in positon ${position.toString()}');
//   //   markers.clear();
//   //    log('markers in GMapController ${markers.toString()}');
//   //   markers.add(
//   //     Marker(
//   //       markerId: const MarkerId('current Location'),
//   //       position: LatLng(position.latitude, position.longitude),
//   //     ),
//   //   );

//   //   log('markers in afer added ${markers.toString()}');
//   //   mapController?.animateCamera(
//   //     CameraUpdate.newCameraPosition(
//   //       CameraPosition(target: position, zoom: 14),
//   //     ),
//   //   );
//   // }

//   //  Future<LocationData> getCurrentLocation() async {
//   //     Location location = Location();
//   //   final locationData = await location.getLocation();
//   //   return locationData;
//   // }
// }

// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationController extends GetxController {
//   var location = ''.obs;
//   var isLoading = false.obs;

//   void fetchLocation() async {
//     isLoading.value = true;

//     try {
//       Position position = await Geolocator.getCurrentPosition();
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);

//       Placemark place = placemarks[0];
//       location.value =
//           '${place.locality}, ${place.administrativeArea}, ${place.country}';
//     } catch (e) {
//       // Handle error
//       print('Error fetching location: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
