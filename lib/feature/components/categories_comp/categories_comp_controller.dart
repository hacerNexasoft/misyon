import 'package:common/common.dart';
import 'package:misyonbank/product/models/category_model.dart';

class CategoriesCompController extends BaseGetxController {
  final categories = <CategoryModel?>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCategories();
  }

  void _fetchCategories() {
    categories.value = [
      CategoryModel(
        id: UniqueKey().toString(),
        name: 'Yapay Zeka',
        imageUrl:
            'https://www.innova.com.tr/medias/yapay-zeka-ve-makine-ogrenimi-teknolojisi-gelismeleri.jpg',
      ),
      CategoryModel(
        id: UniqueKey().toString(),
        name: 'Enerji',
        imageUrl:
            'https://www.ayetek.com/wp-content/uploads/2018/02/yenilenebilir-enerji-nedir.jpg',
      ),
      CategoryModel(
        id: UniqueKey().toString(),
        name: 'Tarım',
        imageUrl:
            'https://www.ekoturk.com/wp-content/uploads/2020/09/tarim-sektoru-salgina-ragmen-buyumeye-devam-ediyor.jpg',
      ),
      CategoryModel(
        id: UniqueKey().toString(),
        name: 'Sağlık',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj2fLksgxgXvnmoBv5e2jerD3TNw7fKejd4w&s',
      ),
    ];
  }
}
