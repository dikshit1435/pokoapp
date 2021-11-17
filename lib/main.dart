import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokoapp/pokemon.dart';
import 'dart:convert';

import 'package:pokoapp/pokemon_data.dart';

void main() {
  runApp(const MaterialApp(
    title: 'PokoMan',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Future<PokeHub> fetchData() async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    return PokeHub.fromJson(decodedJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder<PokeHub>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: snapshot.data!.pokemon!
                    .map((poke) =>   Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>PokeDetail(poke,)),);
                        },
                        child: Hero(
                          tag: poke.img!,
                          child: Card(
                            elevation:3.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:100 ,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(poke.img!))
                                  ),
                                ),
                                Text(poke.name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An error occurred : " + snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
