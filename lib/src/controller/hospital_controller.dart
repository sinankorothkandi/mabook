import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalDetailsController extends GetxController {
  final hospitalDetails = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHospitalDetails();
  }

  void fetchHospitalDetails() {
    FirebaseFirestore.instance
        .collection('hospitalDetails')
        .doc('unique_document_id')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        hospitalDetails.value = snapshot.data()!;
      } else {
        hospitalDetails.value = {};
      }
    });
  }
}
