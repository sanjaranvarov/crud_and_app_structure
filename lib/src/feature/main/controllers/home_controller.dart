import 'package:flutter/material.dart';
import 'package:crud_and_app_structure/src/core/service/network_service.dart';
import 'package:crud_and_app_structure/src/data/entity/item_model.dart';

class HomeController extends ChangeNotifier {
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateDescController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();
  bool isLoading = false;
  List<Item> items = [];

  Future<void> getAllItems() async {
    String? result = await NetworkService.gET(
        NetworkService.apiITEM, NetworkService.emptyParams());
    items = itemFromJson(result!);
    isLoading = true;
    notifyListeners();
  }

  // update
  Future<void> updateItems(Item item) async {
    final updatedProduct = {
      'id': item.id,
      'name': item.name,
      'description': item.description,
      'price': item.price,
    };

    await NetworkService.put('${NetworkService.apiITEM}/${item.id}',
        updatedProduct);
    await getAllItems();
  }

  Future<void> deleteProduct(String productId) async {
    await NetworkService.delete('${NetworkService.apiITEM}/$productId');
    await getAllItems();
  }

  void initState(BuildContext context) {
    getAllItems();
  }

  Future<void> editUserInfo(BuildContext context, String? id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Items updating process',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                     const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                           BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      height: 40,
                      child: TextField(
                        controller: updateNameController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 14),
                          hintText: 'name',
                          hintStyle: TextStyle(
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Description:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      height: 40,
                      child: TextField(
                        controller: updateDescController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 5, left: 14),
                          hintText: 'description',
                          hintStyle: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                    )
                  ],
                ),
               const  SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Price:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                      height: 40,
                      child: TextField(
                        controller: updatePriceController,
                        keyboardType: TextInputType.text,
                        style: const  TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border:  InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 5, left: 14),
                          hintText: 'price',
                          hintStyle: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: MaterialButton(
                    onPressed: () async {
                      Item item = Item(
                          id: id,
                          name: updateNameController.text.trim(),
                          description: updateDescController.text.trim(),
                          price: updatePriceController.text.trim());
                      await updateItems(item).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.greenAccent,
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
