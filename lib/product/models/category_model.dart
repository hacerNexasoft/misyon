import 'package:misyonbank/product/models/base_model.dart';

class CategoryModel extends BaseModel {
    final String? id;
    final String? name;
    final String? imageUrl;

    CategoryModel({
        this.id,
        this.name,
        this.imageUrl,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
    };
    
      @override
      List<Object?> get props => [id, name, imageUrl];
}
