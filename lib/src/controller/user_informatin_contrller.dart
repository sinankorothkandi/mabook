import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mabook/src/model/user_information_model.dart';
import 'package:mabook/src/user_data.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';

class UserDetailsController extends GetxController {
  Rx<DateTime?> dob = Rx<DateTime?>(null);
  Rx<DateTime?> appointmentDate = Rx<DateTime?>(null);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final userFormKey = GlobalKey<FormState>();

  Rx<TextEditingController> numberController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> bloodGroupController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> doctorController = TextEditingController().obs;

  String imageUrls = '';
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

      imageUrls=fileUrl;
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
 Future<Map<String, dynamic>> fetchUserData() async {
      final uid = auth.currentUser!.uid;
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
          userdatas = userDoc.data()as Map<String, dynamic>;

      return userDoc.data() as Map<String, dynamic>;
    }
 Future<void> addUserDetails() async {
  String dateOfBirth = DateFormat('dd-MMM-yyyy').format(dob.value!);

  if (userFormKey.currentState!.validate()) {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!document.exists) {
        Get.snackbar(
          'Error',
          'No existing user data found.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }

      Map<String, dynamic> existingData = document.data() as Map<String, dynamic>;
      String email = existingData['email'] ?? '';
      String password = existingData['password'] ?? '';
      String userName = existingData['userName'] ?? '';

      final userData = UserModele(
        id: uid,
        name: nameController.value.text,
        number: numberController.value.text,
        address: addressController.value.text,
        bloodGroup: bloodGroupController.value.text,
        gender: dropdownValue.value == 'One' ? 'Male' : 'Female',
        dob: dateOfBirth,
        imageUrls: imageUrls.toString(),
        email: email,      
        password: password, 
        userName: userName, 
        chatWith: [], 

      );


      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(userData.toMap());

       Get.snackbar('Added',"Data successfully saved to Firestore.");
      Get.to(const CustomBottomNavigationBar());
      // clearFormControllers();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error adding user details: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
       Get.snackbar("Error ","adding to Firestore: $e");
      return;
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
