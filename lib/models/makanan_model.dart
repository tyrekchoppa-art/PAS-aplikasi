import 'dart:convert';

MakananModel makananModelFromJson(String str) => MakananModel.fromJson(json.decode(str));

class MakananModel {
  final List<Recipe> recipes;

  MakananModel({required this.recipes});

  factory MakananModel.fromJson(Map<String, dynamic> json) => MakananModel(
        recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );
}

class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int caloriesPerServing;
  final String cuisine;
  final String image;
  final double rating;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.caloriesPerServing,
    required this.cuisine,
    required this.image,
    required this.rating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        caloriesPerServing: json["caloriesPerServing"],
        cuisine: json["cuisine"],
        image: json["image"],
        rating: (json["rating"] as num).toDouble(),
      );
}