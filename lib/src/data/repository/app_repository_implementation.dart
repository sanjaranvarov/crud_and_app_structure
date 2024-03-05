import 'package:crud_and_app_structure/src/core/service/network_service.dart';
import 'package:crud_and_app_structure/src/data/entity/item_model.dart';
import 'package:crud_and_app_structure/src/data/repository/app_repository.dart';

class AppRepositoryImplementation implements AppRepository{

  @override
  Future<List<Item>?> getPosts() async{
    List<Item>list = [];
    String? str = await NetworkService.gET(NetworkService.apiITEM, NetworkService.emptyParams());
    if(str != null){
      list = itemFromJson(str);
      return list;
    }else{
      return null;
    }
  }

}