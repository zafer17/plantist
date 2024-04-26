
import 'package:get/get.dart';
import 'package:plantist/controllers/auth_controllers.dart';
import 'package:plantist/models/todoModel.dart';
import 'package:plantist/services/database.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>([]);



  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    String? uid = Get.find<AuthController>().user?.uid;
     todoList.bindStream(Database().todoStream(uid!)); //stream coming from firebase
    print("todoList.value"+todoList.value.toString());
  }
}