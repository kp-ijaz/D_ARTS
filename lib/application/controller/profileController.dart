import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var location = ''.obs;
  var bio = ''.obs;
  var job = ''.obs;
  var experience = ''.obs;
  var imagePath = ''.obs;

  var isLoading = false.obs;

  Future<void> fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    isLoading.value = true;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading.value = false;
      // Prompt user to enable location services
      await _enableLocation();
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading.value = false;
        // Permission denied, show message or navigate to settings
        _showLocationPermissionDeniedSnackbar();
        return;
      }
    }

    // Handle deniedForever case
    if (permission == LocationPermission.deniedForever) {
      isLoading.value = false;
      // Permission denied forever, show message or navigate to settings
      _showLocationPermissionDeniedForeverSnackbar();
      return;
    }

    // Fetch current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;
      location.value =
          '${place.locality}, ${place.administrativeArea}, ${place.country}';
    } catch (e) {
      // Handle location fetch error
      _showLocationFetchErrorSnackbar();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _enableLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Open location settings
      await Geolocator.openLocationSettings();
    }
  }

  void _showLocationPermissionDeniedSnackbar() {
    Get.snackbar(
      'Location Permission Denied',
      'Please grant permission to access your location.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }

  void _showLocationPermissionDeniedForeverSnackbar() {
    Get.snackbar(
      'Location Permission Denied Forever',
      'Please enable location permission in app settings.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }

  void _showLocationFetchErrorSnackbar() {
    Get.snackbar(
      'Location Fetch Error',
      'Failed to fetch location. Please try again later.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }
}
