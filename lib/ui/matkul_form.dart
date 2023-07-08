import 'package:flutter/material.dart';
import 'package:siakad/bloc/matkul_bloc.dart';
import 'package:siakad/model/matkul.dart';
import 'package:siakad/ui/matkul_page.dart';
import 'package:siakad/widget/warning_dialog.dart';

class MatkulForm extends StatefulWidget {
  Matkul? matkul;

  MatkulForm({Key? key, this.matkul}) : super(key: key);

  @override
  _MatkulFormState createState() => _MatkulFormState();
}

class _MatkulFormState extends State<MatkulForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH Matkul";
  String tombolSubmit = "SIMPAN";

  final _kodeMatkulTextboxController = TextEditingController();
  final _namaMatkulTextboxController = TextEditingController();
  final _sksTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.matkul != null) {
      setState(() {
        judul = "UBAH Matkul";
        tombolSubmit = "UBAH";
        _kodeMatkulTextboxController.text = widget.matkul!.kodeMatkul!;
        _namaMatkulTextboxController.text = widget.matkul!.namaMatkul!;
        _sksTextboxController.text = widget.matkul!.sks.toString();
      });
    } else {
      judul = "TAMBAH MATKUL";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeMatkulTextField(),
                _namaMatkulTextField(),
                _sksTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Matkul
  Widget _kodeMatkulTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Matkul"),
      keyboardType: TextInputType.text,
      controller: _kodeMatkulTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Matkul harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Matkul
  Widget _namaMatkulTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Matkul"),
      keyboardType: TextInputType.text,
      controller: _namaMatkulTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Matkul harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat TextboxSKS
  Widget _sksTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "SKS"),
      keyboardType: TextInputType.number,
      controller: _sksTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "SKS harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.matkul != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah Matkul
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Matkul createMatkul = Matkul(id: null);
    createMatkul.kodeMatkul = _kodeMatkulTextboxController.text;
    createMatkul.namaMatkul = _namaMatkulTextboxController.text;
    createMatkul.sks = int.parse(_sksTextboxController.text);
    MatkulBloc.addMatkul(matkul: createMatkul).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const MatkulPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Matkul updateMatkul = Matkul(id: null);
    updateMatkul.id = widget.matkul!.id;
    updateMatkul.kodeMatkul = _kodeMatkulTextboxController.text;
    updateMatkul.namaMatkul = _namaMatkulTextboxController.text;
    updateMatkul.sks = int.parse(_sksTextboxController.text);
    MatkulBloc.updateMatkul(matkul: updateMatkul).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const MatkulPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
