import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/models/todoModel.dart';
import 'package:plantist/services/database.dart';

class TodoCard extends StatelessWidget {
  final String uid;
  final TodoModel todo;

  TodoCard({required this.uid, required this.todo});

    TextEditingController contentupd = TextEditingController();
  TextEditingController headupd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    contentupd.text=todo.content.toString();
    headupd.text=todo.head.toString();

    // Renkler listesi, öncelik değerine göre sıralanmıştır.
    List<Color> priorityColors = [
      Colors.green, // Öncelik 0
      Colors.yellow, // Öncelik 3
      Colors.orange, // Öncelik 2
      Colors.red, // Öncelik 1
    ];

// Öncelik değerine göre renk döndüren bir fonksiyon
    Color getPriorityColor(int priority) {
      if (priority == 1 && priority < priorityColors.length) {
        return priorityColors[3];
      }
      else if (priority == 2 && priority < priorityColors.length) {
        return priorityColors[2];
      }
      else if (priority == 3 && priority < priorityColors.length) {
        return priorityColors[0];
      }

      else {
        return Colors.grey; //
      }
    }

    return Dismissible(
      key: UniqueKey(),

      direction: DismissDirection.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {

          bool confirm = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Delete"),
                content: Text("Do tou want to DELETE"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false), // İptal
                    child: Text("İptal"),
                  ),
                  TextButton(
                    onPressed: () {

                      Navigator.of(context).pop(true);
                    }, // Onayla
                    child: Text("Ok"),
                  ),
                ],
              );
            },
          );

          return confirm; // true ise işlemi gerçekleştir, false ise iptal et
        }
        else if(direction == DismissDirection.startToEnd)
          {
            bool confirm = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Edit"),
                  content: Text("Do tou want to Edit"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false), // İptal
                      child: Text("İptal"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        showUpdateDialog(context);

                      }, // Onayla
                      child: Text("Ok"),
                    ),
                  ],
                );
              },
            );

            return confirm; // true ise işlemi gerçekleştir, false ise iptal et
          }
        return false; // Diğer yönlere kaydırma işlemlerini iptal et
      },


      background:  Container(
        color: Colors.grey,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.edit),
          ],
        ),
      ),
      secondaryBackground: Container(

        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Icon(
             Icons.delete
            ),
          ],
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SizedBox(
          height: 100,
          width: double.infinity, // Kartın genişliğini ekrana göre ayarlayın
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 10),
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Text(todo.head),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          SizedBox(width: 10), // İsteğe bağlı boşluk ekleyebilirsiniz
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: getPriorityColor(todo.priority!),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.watch_later_outlined),
                          SizedBox(width: 5),
                          Text(todo.dateTime!.hour.toString() + ':' + todo.dateTime!.minute.toString()),
                          SizedBox(width: 15),
                          Icon(Icons.calendar_month),
                          SizedBox(width: 5),
                          Text(todo.dateCreated!.day.toString() + "/" + todo.dateCreated!.month.toString() + "/" + todo.dateCreated!.year.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );




  }


  void showUpdateDialog(BuildContext context) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Task"),
          content: Column(
            children: [
              TextFormField(
                controller: headupd,
              ),
              TextFormField(
                maxLines: 5,
                controller: contentupd,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (contentupd.text != "") {
                  Database().updateOne(contentupd.text,headupd.text, uid, todo.todoId);
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar("Error", "NO UPDATE");
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

}
