class Personel{
  int? id;
  String? adiSoyadi;
  String? tcKimlikNo;
  String? unvan;
  String? gorevYeri;

  Personel({this.id, this.adiSoyadi, this.tcKimlikNo, this.unvan, this.gorevYeri});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['adiSoyadi'] = adiSoyadi;
    map['tcKimlikNo'] = tcKimlikNo;
    map['unvan'] = unvan;
    map['gorevYeri'] = gorevYeri;

    return map;
  }

  Personel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.adiSoyadi = map['adiSoyadi'];
    this.tcKimlikNo = map['tcKimlikNo'];
    this.unvan = map['unvan'];
    this.gorevYeri = map['gorevYeri'];
  }
}