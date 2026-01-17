// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

import 'dart:convert';

List<IngredientModel> ingredientModelFromJson(String str) => List<IngredientModel>.from(json.decode(str).map((x) => IngredientModel.fromJson(x)));

String ingredientModelToJson(List<IngredientModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IngredientModel {
    int? idIngredient;
    String? name;
    String? description;
    String? thumbnail;
    dynamic type;

    IngredientModel({
        this.idIngredient,
        this.name,
        this.description,
        this.thumbnail,
        this.type,
    });

    factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
        idIngredient: json["idIngredient"],
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "idIngredient": idIngredient,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "type": type,
    };
}
