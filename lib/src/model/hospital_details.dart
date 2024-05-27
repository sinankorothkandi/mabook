class HospitalDetails {
  final List<String>? images;
  final String? address;
  final String? number;
  final String? about;
  final List<String>? time;

  HospitalDetails({
    this.images,
    this.address,
    this.number,
    this.about,
    this.time,
  });

  factory HospitalDetails.fromJson(Map<String, dynamic> json) {
    return HospitalDetails(
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      address: json['address'],
      number: json['number'],
      about: json['about'],
      time: json['time'] != null ? List<String>.from(json['time']) : [],
    );
  }
}
