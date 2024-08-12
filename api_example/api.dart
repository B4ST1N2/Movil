import 'dart:convert';
import 'package:http/http.dart' as http;


mixin JsonSerializable {
  Map<String, dynamic> toJson();
}

class Pokemon with JsonSerializable {
  final String name;
  final List<String> types;

  Pokemon({
    required this.name,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var typesList = json['types'] as List;
    List<String> types = typesList.map((type) => type['type']['name'] as String).toList();

    return Pokemon(
      name: json['name'],
      types: types,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'types': types,
    };
  }
}

class PokemonApi {
  final String apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=5';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> results = jsonDecode(response.body)['results'];
      List<Pokemon> pokemons = [];

      for (var result in results) {
        final pokemonResponse = await http.get(Uri.parse(result['url']));
        if (pokemonResponse.statusCode == 200) {
          pokemons.add(Pokemon.fromJson(jsonDecode(pokemonResponse.body)));
        } else {
          throw Exception('Failed to load pokemon details');
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}

void main() async {
  PokemonApi api = PokemonApi();
  try {
    List<Pokemon> pokemons = await api.fetchPokemons();
    for (var pokemon in pokemons) {
      print('Name: ${pokemon.name}, Types: ${pokemon.types.join(', ')}');
      print('JSON: ${pokemon.toJson()}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
