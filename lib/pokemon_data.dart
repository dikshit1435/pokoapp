import 'package:flutter/material.dart';
import 'package:pokoapp/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail(this.pokemon);

  bodyWidget(context) => Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 50,
            left: 30,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  Text(
                    pokemon.name!,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text('Height:${pokemon.height!}'),
                  Text('Weight:${pokemon.weight!}'),
                  const Text('Type'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type!
                        .map((t) => FilterChip(
                            backgroundColor: Colors.blueGrey,
                            label:
                                Text(t, style: TextStyle(color: Colors.white)),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text('Weakness'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses!
                        .map((t) => FilterChip(
                            backgroundColor: Colors.redAccent,
                            label: Text(
                              t,
                              style: TextStyle(color: Colors.white),
                            ),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text('Next Evolution'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution!
                        .map(
                          (n){
                            return FilterChip(
                              backgroundColor: Colors.greenAccent,
                              label: Text(n.name!),
                              onSelected: (b) {});
                          }
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon.img!,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(pokemon.img!))),
                )),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Center(child: Text(pokemon.name!)),
        backgroundColor: Colors.cyan,
      ),
      body: bodyWidget(context),
    );
  }
}
