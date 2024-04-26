import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plantist/controllers/auth_controllers.dart';
import 'package:plantist/controllers/todoController.dart';
import 'package:plantist/services/database.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plantist/views/widgets/todo_card.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _todoHeadController=TextEditingController();
  final _isCalenderOpen = false.obs;
  final _isTimeOpen = false.obs;
  final selectedOption = 1.obs;
  late DateTime _selectedTime=DateTime.now();
  late DateTime _selectedDate=DateTime.now();
  final _isSwitchOpen=1.obs;
  final Rx<DateTime> _focusedDay = DateTime.now().obs;

  List<RadioModel> radioOptions = [
    RadioModel(value: 1, label: '0'),
    RadioModel(value: 2, label: '1'),
    RadioModel(value: 3, label: '2'),
    RadioModel(value: 4, label: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.height;
    double sizedBoxheight = (screenWidth / 4) * 3;

    void _showDetailsBottomSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(child: Text("Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.calendar_month,color: Colors.red,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('Date',style: TextStyle(color: Colors.black),),
                          ),
                        ],
                      ),

                      Obx(() => Switch(
                        value: _isSwitchOpen.value == 1,
                        onChanged: (value) {
                          if (value) {
                            _isSwitchOpen.value = 1;
                          } else {
                            _isSwitchOpen.value = 0;
                          }
                        },
                      )),
                    ],
                  ),
                  Obx((){

                    if(_isSwitchOpen.value == 1){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Obx(
                          ()=> TableCalendar(
                            focusedDay: _focusedDay.value,
                            firstDay: DateTime.now(),
                            lastDay: DateTime(2025),
                            onDaySelected: (selectedDay, focusedDay) {
                              print("Focused day:   $_focusedDay.value");
                              _selectedDate = selectedDay;
                              _focusedDay.value = selectedDay;
                              focusedDay= selectedDay;
                              _focusedDay.refresh();
                              print("Focused day:2   $_focusedDay.value");
                              print("Selected day45454: $selectedDay");
                              print("Focused day3: $focusedDay");
                            },
                          ),
                        ),
                      );
                    }else{
                      return SizedBox.shrink();
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.watch_later_outlined,color: Colors.red,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('Time',style: TextStyle(color: Colors.black),),
                          ),
                        ],
                      ),
                      Obx(() => Switch(
                        value: _isTimeOpen.value,
                        onChanged: (value) => _isTimeOpen.value = value,
                      )),
                    ],
                  ),
                  Obx((){
                    if(_isTimeOpen.value){

                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child:TimePickerSpinner(
                            is24HourMode: true,
                            onTimeChange: (time){
                             // DateTime newTime=time.toUtc().subtract(Duration(hours: 3));
                              _selectedTime=time;
                              print("selected"+_selectedTime.toString());
                            },
                          )

                      );
                    }else{
                      return SizedBox.shrink();
                    }}),
                  // Select Priority
                  Column(
                    children: [
                      const Text('Select an option:(Priority)'),
                      Row(
                        children: radioOptions.map((option) => Expanded(
                          child: Obx(() => RadioListTile<int>(
                            title: Text(option.label),
                            value: option.value,
                            groupValue: selectedOption.value,
                            onChanged: (value) {
                              selectedOption.value = value as int;
                              print(selectedOption.value.toString()+"option");
                            },
                          )),
                        )).toList(),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {

                      if (_todoController.text.isNotEmpty) {
                        Database().addTodo(_todoController.text, _todoHeadController.text,controller.user!.uid,selectedOption.value,_selectedTime,_selectedDate);
                        Get.snackbar('Success', 'Reminder added',
                            backgroundColor: Colors.blue,
                            icon: Icon(Icons.check),
                            duration: Duration(seconds: 2));
                        selectedOption.value=1;
                        _todoController.clear();
                        _todoHeadController.clear();
                        Navigator.pop(context);
                      } else {
                        Get.snackbar('Error', 'Please enter a reminder',
                            backgroundColor: Colors.red,
                            icon: Icon(Icons.error),
                            duration: Duration(seconds: 2));
                      }
                    },
                    child: Text("Add Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }





    void _showNewReminderBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child: Text("New Reminder",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),

                  TextField(
                    controller: _todoHeadController,
                    decoration: InputDecoration(hintText: "Head"),
                  ),
                  TextField(
                    maxLines: 5,
                    controller: _todoController,
                    decoration: InputDecoration(hintText: "Notes"),
                  ),
                  ElevatedButton(
                      onPressed:(){
                        _showDetailsBottomSheet();
                      } ,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                              Text("Today",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                            ],
                          ),

                          Icon(Icons.arrow_right,color: Colors.black,),

                        ],
                      )),


                  ElevatedButton(
                    onPressed: () {
                      if (_todoController.text.isNotEmpty) {
                        Database().addTodo(_todoController.text, _todoHeadController.text,controller.user!.uid,selectedOption.value,_selectedTime,_selectedDate);
                        Get.snackbar('Success', 'Reminder added',
                            backgroundColor: Colors.blue,
                            icon: Icon(Icons.check),
                            duration: Duration(seconds: 2));
                        selectedOption.value=1;
                        _todoController.clear();
                        _todoHeadController.clear();
                        Navigator.pop(context);} else {
                        Get.snackbar('Error', 'Please enter a reminder',
                            backgroundColor:Colors.red,
                            icon: Icon(Icons.error),
                            duration: Duration(seconds: 2));
                      }
                    },
                    child: Text("Add Reminder",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          );
        },
      );

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Plantist"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white54,
        child: Column(
          children: [
            GetX<TodoController>(
              init: Get.put<TodoController>(TodoController()),
              builder: (TodoController todoController) {
                if (todoController != null && todoController.todos != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todoController.todos.length,
                      itemBuilder: (_, index) {
                        return TodoCard(
                            uid: controller.user!.uid,
                            todo: todoController.todos[index]);
                      },
                    ),
                  );
                } else {
                  return Text("loading...");
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                _showNewReminderBottomSheet();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.add, color: Colors.white,),
                  SizedBox(width: 100),
                  Text("New Reminder", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );


  }
}

SizedBox Space(double x) => SizedBox(width: x,);

class RadioModel {
  int value;
  String label;

  RadioModel({required this.value, required this.label});
}