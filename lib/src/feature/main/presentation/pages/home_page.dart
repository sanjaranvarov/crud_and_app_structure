import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_controller.dart';
import 'item_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.initState(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Items',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(
              child: Consumer<HomeController>(
                builder: (context, controller, child) {
                  return controller.isLoading
                      ? ListView.builder(
                          itemCount: controller.items.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    // controller.colors[controller.backgroundColor],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name: ${controller.items[index].name}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              controller.updateNameController.text = controller.items[index].name;
                                              controller.updateDescController.text = controller.items[index].description;
                                              controller.updatePriceController.text = controller.items[index].price;
                                              controller.editUserInfo(context, controller.items[index].id);
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.greenAccent,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () async {
                                              await controller.deleteProduct(
                                                  controller.items[index].id
                                                      .toString());
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Description:  ${controller.items[index].description}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Price: \$ ${controller.items[index].price}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const ItemAdd()));
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
