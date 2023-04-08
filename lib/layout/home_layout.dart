import 'package:first_after/modules/home_tasks/archived_tasks.dart';
import 'package:first_after/modules/home_tasks/done_tasks.dart';
import 'package:first_after/modules/home_tasks/new_tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  List<Widget> screens=
  [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String>titles=
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
late Database database;
var scaffoldKey=GlobalKey<ScaffoldState>();
bool isBottomSheetShown=false;
IconData fabIcon=Icons.edit;
var titleController=TextEditingController();
var timeController=TextEditingController();
var dateController=TextEditingController();
var formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isBottomSheetShown)
          {
            if(formKey.currentState!.validate())
            {
              insertToDatabase(
                  title:titleController.text,
                  date: dateController.text,
                  time: timeController.text,
              ).then((value)
              {
                Navigator.pop(context);
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
            }
          } else
          {
            scaffoldKey.currentState?.showBottomSheet((context) =>
                Container(
                  color: Colors.grey[300],
                  padding:EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: titleController,
                          keyboardType:TextInputType.text,
                          validator:(value)
                          {
                             if(value!.isEmpty)
                             {
                               return 'title must not be empty';
                             };
                             return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Task Title'),
                            prefix:Icon(Icons.title),
                            border: OutlineInputBorder(),
                          ),
                          onTap:()
                          {
                            print('title tapped');
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: timeController,
                          keyboardType:TextInputType.datetime,
                          validator:(value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'time must not be empty';
                            };
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Task Time'),
                            prefix:Icon(Icons.watch_later_outlined),
                            border: OutlineInputBorder(),
                          ),
                          onTap:()
                          {
                            showTimePicker(
                                context: context,
                                initialTime:TimeOfDay.now()
                            ).then((value)
                            {
                              timeController.text=value!.format(context).toString();
                              print(value.format(context));
                            });
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: dateController,
                          keyboardType:TextInputType.datetime,
                          validator:(value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'date must not be empty';
                            };
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Task Date'),
                            prefix:Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          onTap:()
                          {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2023-05-03')
                            ).then((value)
                            {
                              print(DateFormat.yMMMd().format(value!));
                              dateController.text=DateFormat.yMMMd().format(value!);
                            }).catchError((error)
                                {
                                  print('error is ${error.toString()}');
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                )
            ).closed.then((value)
            {
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShown=true;
            setState(() {
              fabIcon=Icons.add;
            });
          }
        },
        child:Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex:currentIndex,
        onTap: (index)
        {
          setState(() {
            currentIndex=index;
          });
          print(index);
        },
        items: [
          BottomNavigationBarItem(
          icon:Icon(Icons.menu),
          label: 'Tasks'),
          BottomNavigationBarItem(
              icon:Icon(Icons.check_circle_outline),
              label: 'Done'),
          BottomNavigationBarItem(
              icon:Icon(Icons.archive_outlined),
              label: 'Archived'),
        ],
      ),
    );
  }
  Future<String> getName() async
  {
    return 'saber ';
  }

  void createDatabase()async
  {
    database= await openDatabase(
   'todo.db',
    version: 1,
    onCreate: (database,version)
    {
      // id  Integer
      // title String
      // date String
      // time String
      //status String
      database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT ,time TEXT, status TEXt)').then((value)
      {
        print('table created');
      }).catchError((error){
        print('Error when creating table ${error.toString()}');
      });
      print('database created');
    },
     onOpen: (database)
     {
       print('database open');
     }
   );
  }
  Future insertToDatabase(
  {
    @required title,
    @required date,
    @required time,
  }) async
  {
    await database.transaction((txn)
    async{
      txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
      .then((value)
      {
        print('$value data inserted successfully');
      })
     .catchError((error)
      {
        print('Error when inserting table ${error.toString()}');
      });
    });
  }
}
