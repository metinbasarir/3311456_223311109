class UserModel {
  String? uid;
  String? eposta;
  String? adi;
  String? soyadi;

  UserModel({this.uid, this.eposta, this.adi, this.soyadi});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      eposta: map['eposta'],
      adi: map['adi'],
      soyadi: map['soyadi'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'eposta': eposta,
      'adi': adi,
      'soyadi': soyadi,
    };
  }
}
