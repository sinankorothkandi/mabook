import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorController extends GetxController {
  final searchdata = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<Stream<QuerySnapshot>> doctorStream = Rx<Stream<QuerySnapshot>>(
    FirebaseFirestore.instance.collection('doctoreCollection').snapshots(),
  );
  RxList<QueryDocumentSnapshot> searchResults = <QueryDocumentSnapshot>[].obs;

  void searchDoctors(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      final result = await _firestore
          .collection('doctoreCollection')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      searchResults.assignAll(result.docs);
    } catch (e) {
      print("Error searching doctors: $e");
    }
  }

  Future<void> deleteDoctor(String docId) async {
    try {
      await _firestore.collection('doctoreCollection').doc(docId).delete();
      print("Doctor deleted successfully.");
    } catch (e) {
      print("Error deleting doctor: $e");
    }
  }
}
