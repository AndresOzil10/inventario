import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Json/hostname.dart';
import '../config/constants/enviroment.dart';
import 'details_screen.dart';

// ignore: must_be_immutable
class InfScreen extends StatefulWidget {
  const InfScreen({super.key});

  @override
  State<InfScreen> createState() => _InfScreenState();
}

class _InfScreenState extends State<InfScreen> {
  List items = [];
  List filteredItems = [];
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl,
    )
  );

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    final response = await dio.get('/getdataC.php');
    final jsonResponse = json.decode(response.data);
    setState(() {
      for (final item in jsonResponse) {
        items.add(HostName.fromJson(item));
      }
      filteredItems = items;
    });
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(items);
    if (query.isNotEmpty) {
      List dummyListData = [];
      for (var item in dummySearchList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredItems = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredItems = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff364461),
        foregroundColor: const Color(0xffe0e4ce),
        centerTitle: true,
        title: const Text("Equipment Inventory Kayser"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final list = filteredItems[index];
                return Card(
                  child: ListTile(
                    title: Text(list.name),
                    titleTextStyle: const TextStyle(color: Color(0xff8c162a)),
                    trailing: const Icon(Icons.arrow_right_rounded),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoScreen(list.name),
                        ),
                      )
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
