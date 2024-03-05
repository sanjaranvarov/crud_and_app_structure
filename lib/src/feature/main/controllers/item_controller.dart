import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:crud_and_app_structure/src/data/entity/item_model.dart';
import '../../../core/service/network_service.dart';

class ItemController extends ChangeNotifier{

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<Item> items = [];
  bool isLoading = false;

  Future<void> create() async {
    Item item = Item(
      name: nameController.text.trim(),
      description: descController.text.trim(),
      price: priceController.text.trim(),
    );
    final response = await NetworkService.post(NetworkService.apiITEM, item.toJson());
    if (response != null) {
      nameController.clear();
      descController.clear();
      priceController.clear();
      log("Successfully posted");
    } else {
      log("Failed to add product");
    }
  }


  Future<void> readPosts() async{
    items = await NetworkService.readPosts();
    notifyListeners();
  }

  void initState(BuildContext context){
    readPosts().then((value) {
      isLoading = true;
      notifyListeners();
    });
  }


}