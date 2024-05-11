import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabook/src/model/user_information_model.dart';

class UserDetailsController extends GetxController {
  Rx<DateTime?> dob = Rx<DateTime?>(null);
  Rx<DateTime?> appointmentDate = Rx<DateTime?>(null);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final userFormKey = GlobalKey<FormState>();

  Rx<TextEditingController> numberController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> bloodGroupController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> doctorController = TextEditingController().obs;

  RxList<String> imageUrls = <String>[].obs;
  Rx<File?> imageFile = Rx<File?>(null);

  RxString dropdownValue = 'One'.obs;

  void setDropdownValue(String newValue) {
    dropdownValue.value = newValue;
  }

  RxBool isImageSelected = false.obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      isImageSelected.value = true;
      await uploadImageToFirebase(imageFile.value!);
    } else {
      Get.snackbar(
        "Error",
        "Image not selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> uploadImageToFirebase(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("user_profile")
          .child("${DateTime.now().millisecondsSinceEpoch}");

      final result = await ref.putFile(imageFile);
      final fileUrl = await result.ref.getDownloadURL();

      imageUrls.add(fileUrl);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error in uploading image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<DateTime?> showDOBCalendarDialog(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: dob.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dob.value = pickedDate;
    }
    return pickedDate;
  }

  Future<DateTime?> showAppointmentCalendarDialog(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: appointmentDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      appointmentDate.value = pickedDate;
    }
    return pickedDate;
  }

  Future<void> adduserDetails() async {
    print('fghfgjh-----------------------${auth.currentUser!.uid}');
    if (userFormKey.currentState!.validate()) {
      try {
        final userData = userModele(
          id: '',
        
          name: nameController.value.text,
          number: numberController.value.text,
          address: addressController.value.text,
          bloodGroup: bloodGroupController.value.text,
          gender: dropdownValue.value == 'One' ? 'Male' : 'Female',
          dob: dob.value?.toString() ?? '',
          imageUrls: imageUrls.toString(),
        );

        print("Attempting to save user details to Firestore.");

        await _firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .update(userData.toMap());
        print("Data successfully saved to Firestore.");

        // clearFormControllers();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Error adding hospital details: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        print("------------------------------------");
        print(auth.currentUser?.uid);
        print("Error adding to Firestore: $e");
      }
    }
  }

  void clearFormControllers() {
    numberController.value.clear();
    nameController.value.clear();
    addressController.value.clear();
    doctorController.value.clear();
    bloodGroupController.value.clear();
    dob.value = null;
    imageFile.value = null;
  }
}
