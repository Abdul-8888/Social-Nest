import 'dart:core';
import 'package:chattybuzz/utils/widgets_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/todo_model.dart';
import '../api/todo_crud.dart';

class todoscreen extends StatefulWidget {
  const todoscreen({super.key});

  @override
  State<todoscreen> createState() => _todoscreenState();
}

class _todoscreenState extends State<todoscreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController DateInput = TextEditingController();
  String selectedValue = 'Pending';
  bool isEditpressed = false;
  List<todomodel> list = [];
  bool isloaded = false;
  int updateid = 0;

  getTodos() async {
    try {
      list = await todo_crud().getTodoList();
      if (list != null) {
        setState(() {
          isloaded = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getTodos();
  }

  int getTodoId() {
    int maxID = 0;
    for (var i in list) {
      if (i.id > maxID) {
        maxID = i.id;
      }
    }
    return maxID + 1;
  }

  saveTask(todomodel tm) {
    list.add(tm);
    try {
      todo_crud().saveTodoTaskList(list);
    } catch (e) {
      print(e);
    }
  }

  deleteTask(int id) {
    for (var i in list) {
      if (i.id == id) {
        list.remove(i);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Task has been deleted!')));
        todo_crud().saveTodoTaskList(list);
      }
    }
  }

  Update(todomodel tm) {
    todo_crud()
        .updateTodoTask(list, tm.id, tm.title, tm.deadline, tm.description);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The task " + tm.title + ' has been updated!')));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18.0, left: 12, right: 12, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Todos',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 25.0, right: 25, bottom: 15),
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.title, color: Colors.blue),
                      labelText: 'Task Title',
                      hintText: 'Task Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  addVerticalSpace(5),
                  TextField(
                    controller: DateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month,
                            color: Colors.blue),
                        hintText: 'Deadline',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          DateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        if (mounted) {}
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Date not Selected'),
                          ),
                        );
                      }
                    },
                  ),
                  addVerticalSpace(5),
                  TextFormField(
                    controller: description,
                    maxLines: 4,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.description, color: Colors.blue),
                      labelText: 'Task Description',
                      hintText: 'Task Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  addVerticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.blue.shade100)),
                          onPressed: () async {
                            title.clear();
                            DateInput.clear();
                            description.clear();
                            setState(() {
                              if (isEditpressed == true) {
                                isEditpressed = false;
                              }
                            });
                          },
                          child: Text(
                            'Clear',
                            style: TextStyle(color: Colors.black),
                          )),
                      addHorizontalSpace(5),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.blue.shade100)),
                          onPressed: () async {
                            if (isEditpressed == false) {
                              todomodel tm = todomodel(
                                  title: title.text,
                                  description: description.text,
                                  status: "Pending",
                                  deadline: DateInput.text,
                                  id: getTodoId());
                              await saveTask(tm);
                              title.clear();
                              DateInput.clear();
                              description.clear();
                              getTodos();
                            } else {
                              todomodel tm = todomodel(
                                  title: title.text,
                                  description: description.text,
                                  status: "Pending",
                                  deadline: DateInput.text,
                                  id: updateid);
                              Update(tm);
                              setState(() {
                                isEditpressed = false;
                                title.clear();
                                DateInput.clear();
                                description.clear();
                                getTodos();
                              });
                            }
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              endIndent: 15,
              indent: 15,
            ),
            addVerticalSpace(5),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 12.0, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Todo List",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Visibility(
                    visible: isloaded,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              // Specify a key if the Slidable is dismissible.
                              key: Key(list[index].id.toString()),

                              // The start action pane is the one at the left or the top side.
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                // A pane can dismiss the Slidable.
                                dismissible: DismissiblePane(
                                  key: Key(list[index].id.toString()),
                                  onDismissed: () async {
                                    try {
                                      deleteTask(list[index].id);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                ),

                                // All actions are defined in the children parameter.
                                children: const [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: null,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.blue,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),

                              // The end action pane is the one at the right or the bottom side.
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 2,
                                    onPressed: (context) {
                                      setState(() {
                                        isEditpressed = true;
                                        title.text = list[index].title;
                                        DateInput.text = list[index].deadline;
                                        description.text =
                                            list[index].description;
                                        updateid = list[index].id;
                                      });
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.blue,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              child: Card(
                                margin: const EdgeInsets.all(5),
                                color: Colors.blue.shade100,
                                shadowColor: Colors.white60,
                                elevation: 10,
                                child: Center(
                                  child: ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Title: ' + list[index].title),
                                        SizedBox(
                                          width: 100,
                                          child: DropdownButton(
                                            hint: Text(
                                              list[index].status,
                                            ),
                                            isExpanded: true,
                                            style:
                                                const TextStyle(fontSize: 14),
                                            items: [
                                              'Pending',
                                              'Completed',
                                              'Incomplete'
                                            ].map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  value: val,
                                                  child: Text(
                                                    val,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  todo_crud()
                                                      .updateStatusTodoTask(
                                                          list,
                                                          list[index].id,
                                                          val!);
                                                  getTodos();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      ExpansionPanelList(
                                        children: [
                                          ExpansionPanel(
                                            headerBuilder:
                                                (context, isExpanded) {
                                              return ListTile(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Deadline: ' +
                                                        list[index].deadline),
                                                  ],
                                                ),
                                              );
                                            },
                                            body: ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Description:'),
                                                  Text(
                                                    list[index].description,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  )
                                                ],
                                              ),
                                            ),
                                            isExpanded: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
