          //  return AlertDialog(
          //                 content : Stack(
          //                   children: <Widget>[
          //                          Positioned(
          //                           right: -40.0,
          //                           top: -40.0,
          //                           child: InkResponse(
          //                             onTap: () {
          //                               Navigator.of(context).pop();
          //                             },
          //                             child: CircleAvatar(
          //                               child: Icon(Icons.close),
          //                               backgroundColor: Colors.red,
          //                             ),
          //                           ),
          //                         ),
          //                         Form(
          //                           key: _formKey,
          //                           child: Column(
          //                             mainAxisSize: MainAxisSize.min,
          //                             children: <Widget>[
          //                               Padding(
          //                                 padding: EdgeInsets.all(8.0),
          //                                 child: TextFormField(
          //                                   controller: addUserController['name'],
          //                                   decoration: const InputDecoration(hintText : "이름"),
          //                                   validator: (value) {
          //                                     if(value == null || value.isEmpty){
          //                                       return "이름을 입력해주세요.";
          //                                     }
          //                                     return null;
          //                                 },),
          //                               ),
          //                               Padding(
          //                                 padding: EdgeInsets.all(8.0),
          //                                 child: TextFormField(
          //                                   controller: addUserController['phone_number'],
          //                                   validator: (value) {
          //                                     Pattern phonePattern = r'^01$';
          //                                     RegExp phoneRegExp = new RegExp(r'^(?:\d{3}|\(\d{3}\))([-\/\.])\d{4}\1\d{4}$');
          //                                     if(value == null || value.isEmpty){
          //                                       return "전화번호를 입력해주세요.";
          //                                     }
          //                                     if(!phoneRegExp.hasMatch(value)){
          //                                       return "###-####-#### 형식으로 입력해주세요";
          //                                     }
          //                                     return null;
          //                                   },
          //                                   keyboardType: TextInputType.phone,
          //                                   decoration: const InputDecoration(hintText : "전화번호"),
                                            
          //                                   //  inputFormatters: [ 
          //                                   //   FilteringTextInputFormatter.allow(RegExp('^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}')),
          //                                   //  ],
          //                                   // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),],
                        
          //                                 ),
          //                               ),
                                 
          //                             ],
          //                           ),
          //                         ),
          //                     ],
          //                 ),
          //                 actions: <Widget>[
          //                   TextButton(
          //                     onPressed :() {
          //                       print(  _formKey.currentState);
                                
          //                         if(!_formKey.currentState!.validate()){
          //                             // _formKey.currentState!.save();
          //                            // To get data I wrote an extension method bellow
          //                             return;
          //                             // print(_formKey.values);
          //                         };
                                
          //                       UserService().create({
          //                         "name" : addUserController['name']!.text,
          //                         "phone_number" : addUserController['phone_number']!.text
          //                       })
          //                       .then((result){
                                  
                                  
          //                         if(result['object'] != 'error'){
          //                           setState(() {
          //                             print(result['id']);
                                      
          //                             _employees.add(Employee(result['id'],result['properties']['name']['rich_text'][0]["text"]["content"],result['properties']['phone_number']["phone_number"]));
          //                             _employeeDataSource = EmployeeDataSource(_employees); 
          //                             Navigator.of(context).pop();
          //                           });
          //                         }
                                  
                                  
          //                       });
                                
                                
          //                       //       _formKey.currentState.save();
          //                       // }
          //                     }, 
          //                     child: const Text("확인")
          //                   ),
          //                   TextButton(
          //                     onPressed :() {
          //                        Navigator.of(context).pop();
          //                     }, 
          //                     child: const Text("취소")
          //                   )
          //                 ],
          //               );


