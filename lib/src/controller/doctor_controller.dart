

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<Stream<QuerySnapshot>> doctorStream = Rx<Stream<QuerySnapshot>>(
    FirebaseFirestore.instance.collection('doctoreCollection').snapshots(),
  );

  Future<void> deleteDoctor(String docId) async {
    try {
      await _firestore.collection('doctoreCollection').doc(docId).delete();
      print("Doctor deleted successfully.");
    } catch (e) {
      print("Error deleting doctor: $e");
    }
  }
}
