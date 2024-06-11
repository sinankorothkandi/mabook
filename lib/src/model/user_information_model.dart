import 'package:cloud_firestore/cloud_firestore.dart';

class userModele {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? userName;
  final String? imageUrls;
  final String? number;
  final String? address;
  final String? bloodGroup;
  final String? gender;
  final String? dob;
   List<String>? chatWith;


  userModele( {
     this.id,
    this.email,
    this.userName,
     this.password,
     this.name,
     this.number,
     this.address,
     this.bloodGroup,
     this.gender,
     this.dob,
     this.imageUrls,
      this.chatWith,
  });

  factory userModele.fromMap(DocumentSnapshot map) {
    return userModele(
      id: map.id,
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      address: map['address'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      gender: map['gender'] ?? false,
      dob: map['dob'] ?? '',
      email: map["email"] ??'',
      userName: map["userName"]??'',
      password: map["password"]??'',
      imageUrls:map['imageUrls'] ?? '',
      chatWith:map['chatWith'] ?? '',

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'address': address,
      'bloodGroup': bloodGroup,
      'gender': gender,
      'dob': dob,
      'imageUrls': imageUrls,
      "email": email,
      "userName": userName,
      "password": password,
      "chatWith":chatWith,

    };
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// class userModele {
//   final String id;
//   final String name;
//   final List<String> imageUrls;
//   final String number;
//   final String address;
//   final String bloodGroup;
//   final String gender; 
//   final String dob;

//   userModele({
//     required this.id,
//     required this.name,
//     required this.number,
//     required this.address,
//     required this.bloodGroup,
//     required this.gender,
//     required this.dob,
//     required this.imageUrls,
//   });

//   factory userModele.fromMap(DocumentSnapshot map) {
//     return userModele(
//       id: map.id,
//       name: map['name'] ?? '',
//       number: map['number'] ?? '', 
//       address: map['address'] ?? '',
//       bloodGroup: map['bloodGroup'] ?? '',
//       gender: map['gender'] ?? false, 
//       dob: map['dob'] ?? '',
//       imageUrls: List<String>.from(map['imageUrls'] ?? []),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'number': number,
//       'address': address,
//       'bloodGroup': bloodGroup,
//       'gender': gender,
//       'dob': dob,
//       'imageUrls': imageUrls,
//     };
//   }
// }

