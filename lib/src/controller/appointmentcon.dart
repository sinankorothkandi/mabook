import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/firebase.dart';
import 'package:mabook/src/controller/user_informatin_contrller.dart';
import 'package:mabook/src/user_data.dart';

class AppoinmentController extends GetxController {
  Rx<TextEditingController> diseaseController = TextEditingController().obs;
  final appointmentFormKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userId = auth.currentUser!.uid;
  bool isCanceled = false;
  bool isCompleated = false;

  final UserDetailsController ctrl = Get.put(UserDetailsController());
  Future<void> addappoinmentToFirebase(doctorname, amount, selectedDate,
      selectedTokens, doctorid, doctorData, context) async {
    await ctrl.fetchUserData();

    if (appointmentFormKey.currentState!.validate()) {
      try {

        DocumentReference newDocRef =
            await _firestore.collection('appoinmentsCollection').add({
          'disease': diseaseController.value.text,
          'doctor': doctorname,
          'date': selectedDate.toString(),
          'token': selectedTokens.toString(),
          'paid': amount.toString(),
          'doctorid': doctorid,
          'userid': userId,
          'doctorData': doctorData,
          'userData': userdatas,
          'prescription ': null,
          'Examinations': null,
          'Advance ': null,
          'iscanceled': isCanceled = false,
          'isCompleated': isCompleated = false,
        });
        String appointmentId = newDocRef.id;
        await _firestore
            .collection('appoinmentsCollection')
            .doc(appointmentId)
            .update({
          'appointmentId': appointmentId,
        });
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        Get.snackbar('error',' booking appoinmet : $e');
      }
    }
  }

  String bookedTokenNumbers = '';
  fetchAppointmentDetails(selectedDate, String doctorid) async {

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('appoinmentsCollection')
          .where('date', isEqualTo: selectedDate.toString())
          .where('doctorid', isEqualTo: doctorid)
          .get();
          
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        bookedTokenNumbers = data['token'];
      } else {
        // print("Error  No user found with the provided ID.");
      }
    } catch (e) {
      Get.snackbar('Error',e.toString());
    }
  }

  Future<void> updateappoinmentToFirebase(
      userdatas, appointmentData, doctorData, context) async {
    try {
      await _firestore
          .collection('appoinmentsCollection')
          .doc(appointmentData['appointmentId'])
          .update({
        'disease': appointmentData['disease'],
        'date': appointmentData['date'],
        'token': appointmentData['token'],
        'paid': appointmentData['paid'],
        'doctorid': appointmentData['doctorid'],
        'userid': userdatas['id'],
        'doctorData': doctorData,
        'userData': userdatas,
        'prescription ': appointmentData['prescription '],
        'Examinations': appointmentData['Examinations'],
        'Advance ': appointmentData['Advance '],
        'iscanceled': true,
        'isCompleated': appointmentData['isCompleated'],
      });
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar('Error','ubdate appoinmet : $e');
    }
  }
}