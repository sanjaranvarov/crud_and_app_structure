import 'package:crud_and_app_structure/src/data/entity/item_model.dart';

abstract class AppRepository{

  Future<List<Item>?>getPosts();

}