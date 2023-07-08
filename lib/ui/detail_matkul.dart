import 'package:siakad/model/matkul.dart';
import 'package:flutter/material.dart';

class MatkulDetail extends StatefulWidget {
  final String? kodeMatkul;
  final String? namaMatkul;
  final int? sks;

  const MatkulDetail(
      {Key? key,
      this.kodeMatkul,
      this.namaMatkul,
      this.sks,
      required Matkul matkul})
      : super(key: key);
  @override
  _MatkulDetaillState createState() => _MatkulDetaillState();
}

class _MatkulDetaillState extends State<MatkulDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mata Kuliah'),
      ),
      body: Column(
        children: [
          Text("Kode Mata Kuliah : " + widget.kodeMatkul.toString()),
          Text("Nama Mata Kuliah : ${widget.namaMatkul}"),
          Text("Sks : ${widget.sks}")
        ],
      ),
    );
  }
}
