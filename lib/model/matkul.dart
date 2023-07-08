class Matkul {
  int? id;
  String? kodeMatkul;
  String? namaMatkul;
  int? sks;

  Matkul({this.id, this.kodeMatkul, this.namaMatkul, this.sks});

  factory Matkul.fromJson(Map<String, dynamic> obj) {
    return Matkul(
        id: obj['id'],
        kodeMatkul: obj['kode_matkul'],
        namaMatkul: obj['nama_matkul'],
        sks: obj['sks']);
  }
}
