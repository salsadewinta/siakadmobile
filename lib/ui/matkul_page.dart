import 'package:flutter/material.dart';
import 'package:siakad/bloc/logout_bloc.dart';
import 'package:siakad/bloc/matkul_bloc.dart';
import 'package:siakad/model/matkul.dart';
import 'package:siakad/ui/login_page.dart';
import 'package:siakad/ui/detail_matkul.dart';
import 'package:siakad/ui/matkul_form.dart';

class MatkulPage extends StatefulWidget {
  const MatkulPage({Key? key}) : super(key: key);

  @override
  _MatkulPageState createState() => _MatkulPageState();
}

class _MatkulPageState extends State<MatkulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Matkul'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MatkulForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()))
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: MatkulBloc.getMatkuls(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListMatkul(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListMatkul extends StatelessWidget {
  final List? list;

  const ListMatkul({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemMatkul(
            matkul: list![i],
          );
        });
  }
}

class ItemMatkul extends StatelessWidget {
  final Matkul matkul;
  const ItemMatkul({Key? key, required this.matkul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MatkulDetail(
                      matkul: matkul,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(matkul.namaMatkul!),
          subtitle: Text(matkul.sks.toString()),
        ),
      ),
    );
  }
}
