import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HospitalCollection extends GetxController{
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Rx stream to manage doctor data
  final Rx<Stream<QuerySnapshot>> doctorStream = Rx<Stream<QuerySnapshot>>(
    FirebaseFirestore.instance.collection('hospitalDetails').snapshots(),
  );

  // Method to delete a doctor by document ID
  Future<void> deleteDoctor(String docId) async {
    try {
      await _firestore.collection('hospitalDetails').doc(docId).delete();
      print("Doctor deleted successfully.");
    } catch (e) {
      print("Error deleting doctor: $e");
    }
  }
}