import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:user_manager/configs/colors.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/domain/entities/user.dart';
class UserForm extends StatefulWidget {
  // const UserForm({Key? key}) : super(key : key);
  final User? user;
  final void Function(UserProperty)? onPress;
  final String msg;
  const UserForm({this.user, this.onPress, this.msg = ""});
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  User? get user => widget.user;
  get onPress => widget.onPress;
  String get msg => widget.msg;
  String color = UserColor.defaultColor.value.toString();

  void initState() {
    this.color = (user != null ? user?.color : color)!;
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    final _formKey = GlobalKey<FormState>();
    final Map<String,TextEditingController> formController = {
      "description" :TextEditingController(text : user != null ?  user!.description : ""),
      "name" : TextEditingController(text : user != null ?  user!.name : ""),
      "phoneNumber" : TextEditingController(text : user != null ?  user!.phoneNumber : ""),
    };
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
              child: const CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            key : _formKey,
            child : Column(
              mainAxisSize : MainAxisSize.min,
              children : <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: formController['name'],
                    decoration: const InputDecoration(hintText : "??????", labelText: "??????"),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "????????? ??????????????????.";
                      }
                      return null;
                    },),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: formController['phoneNumber'],
                    validator: (value) {
                      RegExp phoneRegExp = new RegExp(r'^(?:\d{3}|\(\d{3}\))([-\/\.])\d{4}\1\d{4}$');
                      if(value == null || value.isEmpty){
                        return "??????????????? ??????????????????.";
                      }
                      if(!phoneRegExp.hasMatch(value)){
                        return "###-####-#### ???????????? ??????????????????";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText : "????????????", labelText : "????????????"),

                    //  inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}')),
                    //  ],
                    // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),],

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: formController['description'],
                    decoration: const InputDecoration(hintText : "??????", labelText: "??????"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      showLabel: false,
                                      labelTypes: [],
                                      pickerColor: Color(int.parse(color)),
                                      onColorChanged: (Color color){
                                        // formController['color']!.value = color.value.toString() as TextEditingValue;
                                        setState((){
                                          this.color = color.value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('??????'),
                                      onPressed: () {
                                        // setState(() => currentColor = pickerColor);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        icon: Icon(Icons.square,color: Color(int.parse(color))),
                        iconSize: 60.0,
                      ),
                      Text("????????? ??????????????????."),
                    ],
                  )

                )
              ]
            )
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed :() {


              if(_formKey.currentState!.validate()){

                // To get data I wrote an extension method bellow
                _formKey.currentState!.save();
                final String name = formController['name']!.text.toString();
                final String phoneNumber = formController['phoneNumber']!.text.toString();
                final String description = formController['description']!.text.toString();
                final String color = this.color;
                final UserProperty userProperty = UserProperty(
                    name : name,
                    phoneNumber: phoneNumber,
                    description: description,
                    color : color
                );
                // userBloc.add(UserCreated(userProperty));
                onPress!(userProperty);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                    )
                );
              };
            },
            child: const Text("??????")
        ),
        TextButton(
            onPressed :() {
              Navigator.of(context).pop();
            },
            child: const Text("??????")
        )
      ],
    );
  }
}