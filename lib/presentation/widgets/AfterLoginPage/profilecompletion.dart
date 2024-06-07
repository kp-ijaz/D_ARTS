// import 'dart:developer';

import 'package:d_art/application/controller/profileController.dart';
import 'package:d_art/presentation/serviceprovider/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'serviceselectionpage.dart';

class ProfileCompletionPage extends StatelessWidget {
  final String job;
  final ProfileController controller = Get.put(ProfileController());

  ProfileCompletionPage({required this.job});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.job.value = job;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 25, left: 25, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _pickImage(),
                child: Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.imagePath.value.isNotEmpty
                          ? FileImage(File(controller.imagePath.value))
                          : null,
                      child: controller.imagePath.value.isEmpty
                          ? const Icon(Icons.add_a_photo, size: 50)
                          : null,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                ),
                onChanged: (value) => controller.name.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                ),
                onChanged: (value) => controller.phone.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => controller.fetchLocation(),
                child: AbsorbPointer(
                  child: Obx(() {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enable your location',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        prefixIcon: Icon(Icons.location_on, color: Colors.red),
                      ),
                      validator: (value) {
                        if (controller.location.value.isEmpty) {
                          return 'Please enable your location';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                        text: controller.location.value,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                ),
                onChanged: (value) => controller.bio.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Job',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                ),
                readOnly: true,
                controller: TextEditingController(
                  text: controller.job.value,
                ),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ServiceSelectionPage()));
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Experience',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                ),
                onChanged: (value) => controller.experience.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your experience';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showProfile(context);
                      }
                    },
                    child: const Text('Complete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.imagePath.value = pickedFile.path;
    }
  }

  void _showProfile(BuildContext context) {
    final profileData = {
      'Name': controller.name.value,
      'Phone': controller.phone.value,
      'Location': controller.location.value,
      'Bio': controller.bio.value,
      'Job': controller.job.value,
      'Experience': controller.experience.value,
    };

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfilePage(profileData: profileData),
    ));
  }
}
