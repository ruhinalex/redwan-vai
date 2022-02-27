import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ReadSura.dart';
import '../config.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({Key? key}) : super(key: key);

  Future<List> getSuraList() async {
    http.Response response = await http
        .get(Uri.parse("${Config.urlRoot}${Config.endPoint_suraList}"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Data loading error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff8bd58),
        title: Center(
          child: Text(
            'আল কোরআন',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getSuraList(),
        builder: (BuildContext context, AsyncSnapshot<List> sn) {
          if (sn.hasData) {
            List? suraList = sn.data;
            return Container(
              color: Color(0xfffaf7bb),
              child: ListView.builder(
                  itemCount: suraList!.length,
                  itemBuilder: (context, int index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ReadSuraPage(
                                name: suraList[index]["name"],
                                id: suraList[index]["id"],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Color(0xfff8bd58),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Color(0xfffaf7bb),
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              "${suraList[index]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
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
