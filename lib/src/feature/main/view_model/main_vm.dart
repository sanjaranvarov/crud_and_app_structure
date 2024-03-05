import 'dart:developer';
import 'package:crud_and_app_structure/src/data/entity/item_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/repository/app_repository_implementation.dart';

class MainVM with ChangeNotifier{
  List<Item> posts = [];
  bool isLoading = false;
  AppRepositoryImplementation appRepositoryImplementation = AppRepositoryImplementation();


  Future<void>getAllPosts()async{
    isLoading = false;
    posts = await appRepositoryImplementation.getPosts() ?? [];
    isLoading = true;
  }

  MainVM(){
    log("message");
    getAllPosts();
  }

}