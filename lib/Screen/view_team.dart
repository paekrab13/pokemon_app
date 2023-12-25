import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/Screen/create_team.dart';

class ViewTeamScreen extends StatefulWidget {
  const ViewTeamScreen({Key? key}) : super(key: key);

  @override
  State<ViewTeamScreen> createState() => _ViewTeamState();
}

class _ViewTeamState extends State<ViewTeamScreen> {
  List pokedex = [];
  Map? dataReceive;
  String? convertDataName;
  String? convertDataImg;
  static List<Map<String, dynamic>> listPokemonData = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.6),
          ),
          title: Text(
            'My Team',
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.2),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.black.withOpacity(0.6),
              ),
              onPressed: () async {
                dataReceive = await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateTeam()));
                listPokemonData.add({
                  'teamName': dataReceive!['teamName'],
                  'memberNameList': dataReceive!['memberNameList'],
                  'memberImgList': dataReceive!['memberImgList'],
                });

                setState(() {});
              },
            )
          ],
        ),
        body: listPokemonData.isNotEmpty
            ? Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'images/pokeball.png',
                      width: 500,
                      fit: BoxFit.fitWidth,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: listPokemonData.length,
                      itemBuilder: (context, index1) {
                        return Card(
                          color: Colors.blueGrey.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                              child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(listPokemonData[index1]['teamName']),
                              const SizedBox(height: 10),
                              GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 1.4),
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: listPokemonData[index1]['memberNameList'].length,
                                  itemBuilder: (context, index2) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            CachedNetworkImage(
                                                imageUrl: listPokemonData[index1]['memberImgList'][index2],
                                                height: 70,
                                                fit: BoxFit.fitHeight,
                                                placeholder: (context, url) => const Center(
                                                      child: CircularProgressIndicator(),
                                                    )),
                                            Text(listPokemonData[index1]['memberNameList'][index2],
                                                style: TextStyle(
                                                  color: Colors.black.withOpacity(0.6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ))
                                          ],
                                        )
                                      ],
                                    );
                                  })
                            ],
                          )),
                        );
                      }),
                ],
              )
            : Container(
                color: Colors.grey.withOpacity(0.2),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/pokeball.png',
                        width: 500,
                        fit: BoxFit.fitWidth,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                    Center(
                        child: Text(
                      'Please Create Team',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ))
                  ],
                ),
              ));
  }

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com', '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data['pokemon'];

        setState(() {});
      }
    }).catchError((e) {
      // print(e);
    });
  }
}
