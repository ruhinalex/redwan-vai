import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadSuraPage extends StatelessWidget {
  final String name;
  final String id;

  ReadSuraPage({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  Future<List> getSuraData(String id) async {
    http.Response res = await http
        .get(Uri.parse("https://alquranbd.com/api/tafheem/suraData/$id/1"));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Data loading failed");
    }
  }

  String joinBnAyat(List ayas) {
    String fullAya = "";
    for (Map one_aya in ayas) {
      fullAya = "$fullAya ${one_aya["token_trans"]}";
    }
    return fullAya;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff8bd58),
        title: Center(
            child: Text(name,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
      ),
      body: FutureBuilder(
        future: getSuraData(id),
        builder: (BuildContext context, AsyncSnapshot<List> sn) {
          if (sn.hasData) {
            List? ayats = sn.data;
            return Container(
              color: Color(0xfffaf7bb),
              child: ListView.builder(
                itemCount: ayats!.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  color: Color(0xfff8bd58),
                  child: ListTile(
                    leading: Text(
                      "${ayats[index]["ayah_no"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "${ayats[index]["ayah_text"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${joinBnAyat(ayats[index]["bn"])}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          } else if (sn.hasError) {
            return Center(
              child: Text("Error retreiving data"),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(strokeWidth: 3.0, color: Colors.blue),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading....."),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
