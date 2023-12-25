import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/Screen/list_team_pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pokemon_data_model.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  late FocusNode myFocusNode;
  TextEditingController inputController = TextEditingController();
  Map? data;
  int number = 0;
  static List<String> pokemonName = [];
  static List<String> pokemonImg = [];
  static List<String> pokemonId = [];

  final List<pokemonNameModel> pokemonData = List.generate(
      pokemonName.length, (index) => pokemonNameModel(pokemonName[index], pokemonImg[index], pokemonId[index]));
  late SharedPreferences teamName;
  late SharedPreferences memberPokemonName;
  late SharedPreferences memberPokemonImg;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    number = 0;
    pokemonName = [];
    pokemonImg = [];
    pokemonId = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.6),
          ),
          title: Text(
            'Create Team',
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
                data = await Navigator.push(context, MaterialPageRoute(builder: (_) => const ListTeamPokemon()));

                if (!pokemonId.contains(data!['id'])) {
                  pokemonId.add(data!['id']);
                  pokemonName.add(data!['name']);
                  pokemonImg.add(data!['img']);
                  setState(() {
                    if (number < 6) {
                      number = number + 1;
                    }
                  });
                }
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'images/pokeball.png',
                width: 500,
                fit: BoxFit.fitWidth,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.2),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: inputController,
                      focusNode: myFocusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a team name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: width,
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.4,
                        ),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: number,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const SizedBox(width: 15),
                              Column(
                                children: [
                                  CachedNetworkImage(
                                      imageUrl: pokemonImg[index].toString(),
                                      height: 80,
                                      fit: BoxFit.fitHeight,
                                      placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          )),
                                  Text(pokemonName[index],
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      )),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          color: Colors.grey.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: SizedBox(
              height: 50,
              width: width,
              child: ElevatedButton(
                onPressed: () {
                  String enteredText = inputController.text;
                  Navigator.pop(
                    context,
                    {
                      'teamName': enteredText,
                      'memberNameList': pokemonName,
                      'memberImgList': pokemonImg,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                child: const Text('Confirm'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  keepDataLocal() async {
    teamName = await SharedPreferences.getInstance();
    memberPokemonName = await SharedPreferences.getInstance();
    memberPokemonImg = await SharedPreferences.getInstance();
    teamName.setString("INPUT_TEAMNAME", inputController.text.toString());
    memberPokemonName.setStringList("NAME_POKEMON", pokemonName);
    memberPokemonImg.setStringList("IMAGE_POKEMON", pokemonImg);
  }
}
