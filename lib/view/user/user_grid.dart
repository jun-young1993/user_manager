

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:flutter/services.dart';
import 'package:user_manager/service/user_service.dart';
  
  
// import 'package:flutter/foundation.dart';
class UserGrid extends StatelessWidget {
  const UserGrid({super.key});


  @override
  Widget build(BuildContext context){
    return const MyHomePage();
  }
  
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  late List<Employee>  _employees;
  late EmployeeDataSource _employeeDataSource;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
   
      super.initState();
      UserService().index()
      .then((results){
        setState(() {
          _employees = getEmployeeData(results);  
          _employeeDataSource = EmployeeDataSource(_employees);
        });
        
      });

      _employees = [];
      _employeeDataSource = EmployeeDataSource(_employees);
 
    
  }
  final Map<String, TextEditingController> addUserController = {
      'name': TextEditingController(),
      'phone_number': TextEditingController()
    };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title : const Text("사용자"),
            actions : <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed : (){

              }),
              IconButton(
                icon: const Icon(Icons.person_add_rounded),
                onPressed : (){
                   
                    // UserService().index();
                    showDialog(
                      barrierDismissible: false,
                      context : context,
                      builder : (BuildContext context){
                        return AlertDialog(
                          content : Stack(
                            children: <Widget>[
                                   Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: addUserController['name'],
                                            decoration: const InputDecoration(hintText : "이름"),
                                            validator: (value) {
                                              if(value == null || value.isEmpty){
                                                return "이름을 입력해주세요.";
                                              }
                                              return null;
                                          },),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: addUserController['phone_number'],
                                            validator: (value) {
                                              Pattern phonePattern = r'^01$';
                                              RegExp phoneRegExp = new RegExp(r'^(?:\d{3}|\(\d{3}\))([-\/\.])\d{4}\1\d{4}$');
                                              if(value == null || value.isEmpty){
                                                return "전화번호를 입력해주세요.";
                                              }
                                              if(!phoneRegExp.hasMatch(value)){
                                                return "###-####-#### 형식으로 입력해주세요";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.phone,
                                            decoration: const InputDecoration(hintText : "전화번호"),
                                            
                                            //  inputFormatters: [ 
                                            //   FilteringTextInputFormatter.allow(RegExp('^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}')),
                                            //  ],
                                            // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),],
                        
                                          ),
                                        ),
                                 
                                      ],
                                    ),
                                  ),
                              ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed :() {
                                print(  _formKey.currentState);
                                
                                  if(!_formKey.currentState!.validate()){
                                      // _formKey.currentState!.save();
                                     // To get data I wrote an extension method bellow
                                      return;
                                      // print(_formKey.values);
                                  };
                                
                                UserService().create({
                                  "name" : addUserController['name']!.text,
                                  "phone_number" : addUserController['phone_number']!.text
                                })
                                .then((result){
                                  
                                  
                                  if(result['object'] != 'error'){
                                    setState(() {
                                      print(result['id']);
                                      
                                      _employees.add(Employee(result['id'],result['properties']['name']['rich_text'][0]["text"]["content"],result['properties']['phone_number']["phone_number"]));
                                      _employeeDataSource = EmployeeDataSource(_employees); 
                                      Navigator.of(context).pop();
                                    });
                                  }
                                  
                                  
                                });
                                
                                
                                //       _formKey.currentState.save();
                                // }
                              }, 
                              child: const Text("확인")
                            ),
                            TextButton(
                              onPressed :() {
                                 Navigator.of(context).pop();
                              }, 
                              child: const Text("취소")
                            )
                          ],
                        );
                      });
                    
                 
                    // setState(() {
                    //   _employees.add(Employee('id','name'));
                    //   _employeeDataSource = EmployeeDataSource(_employees); 
                    // });
                   
                  
                })
            ]
          ),
          body: SfDataGrid(
            onCellTap :(details) {
              inspect(details);
            },
            allowSorting: true,
            selectionMode: SelectionMode.single,
            source: _employeeDataSource,
            columnWidthMode: ColumnWidthMode.auto,
          //     horizontalScrollPhysics: NeverScrollableScrollPhysics(),
          // verticalScrollPhysics: NeverScrollableScrollPhysics(),
            isScrollbarAlwaysShown: true,
            columns: [
              GridTextColumn(
                  visible: false,
                  columnName: 'id',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ID',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              GridTextColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '이름',
                        // overflow: TextOverflow.ellipsis,
                      ))),
              GridTextColumn(
                  columnName: 'phone_number',
                  label: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.center,
                      child: Text(
                        '연락처',
                        softWrap: true,
                        
                        // overflow: TextOverflow.ellipsis,
                      ))),
            ],
          ),
        )
    );
  }

  
   
  List<Employee> getEmployeeData(List users) {
      
    final List<Employee> initEmployee = [];
    users.forEach((user) {
      
      initEmployee.add(Employee(user['id'], user['name'], user['phone_number']));
    });
    
    
    return initEmployee;
    
  }
}


class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(columnName: 'phone_number', value: dataGridRow.phone_number)
            ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
           padding: EdgeInsets.symmetric(horizontal: 16.0),
           alignment: (dataGridCell.columnName == 'id')
               ? Alignment.centerRight
               : Alignment.centerLeft,
          child: Text(
              dataGridCell.value.toString(),
              softWrap: true,
              // overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.phone_number);
  final String id;
  final String name;
  final String phone_number;
  
}