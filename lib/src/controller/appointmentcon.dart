import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/view/const/bottom_navebar.dart';
import 'package:mabook/src/view/home/home/home.dart';

class AppoinmentController extends GetxController {
  Rx<TextEditingController> diseaseController = TextEditingController().obs;
  final appointmentFormKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addappoinmentToFirebase(
      doctorname, amount, selectedDate, selectedTokens) async {
    if (appointmentFormKey.currentState!.validate()) {
      try {
        print('================Eeeeeee:');

        await _firestore.collection('appoinmentsCollection').add({
          'disease': diseaseController.value.text,
          'doctor': doctorname,
          'date': selectedDate.toString(),
          'token': selectedTokens.toString(),
          'paid': amount.toString(),
        });
      } catch (e) {
        print('================Error booking appoinmet : $e');
      }
      Get.to(() => const CustomBottomNavigationBar());
    }
  }
}
