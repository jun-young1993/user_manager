import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:date_field/date_field.dart';
import 'dart:developer';

class ScheduleForm extends  StatelessWidget{
  late Schedule schedule;
  final void Function(Schedule)? onPress;
  final String msg;
  ScheduleForm({
    required this.schedule,
    this.onPress,
    this.msg = ""
  });

  @override
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();

    final Map<String,TextEditingController> formController = {
      "eventName" :TextEditingController(),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children : <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: schedule.eventName,

                    onChanged: (String? value){
                      schedule = schedule.setEventName(value ?? "");
                    },
                    // controller: formController['eventName'],
                    decoration: const InputDecoration(hintText : "", labelText:  "일정 제목"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeFormField(
                    initialValue: schedule.from,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: '일정 날짜',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      schedule = schedule.setFrom(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeFormField(
                    initialValue: schedule.from,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: '시작 시간',
                    ),
                    mode: DateTimeFieldPickerMode.time,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e){

                      if(e != null){
                        if(schedule.from.difference(schedule.to).inMinutes > 1){
                          return "종료시간 이전으로 선택해주세요.";
                        }
                      }else{
                        return "시작시간을 선택해주세요.";
                      }



                      return null;
                    },
                    onDateSelected: (DateTime value) {
                      schedule = schedule.setFrom(value);

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeFormField(
                    initialValue: schedule.to,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: '종료 시간',
                    ),
                    mode: DateTimeFieldPickerMode.time,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) {

                      if(e != null){

                        if(schedule.from.toLocal().difference(schedule.to.toLocal()).inMinutes > 1){
                          return "시작시간 이후로 선택해주세요.";
                        }
                      }else{
                        return "종료시간을 선택해주세요.";
                      }
                      return null;
                    },
                    onDateSelected: (DateTime value) {
                      schedule = schedule.setTo(value);
                    },
                  ),
                )
              ]
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child : const Text("확인"),
          onPressed: (){
            print(_formKey.currentState);
print("_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
            print("start schedule Date ${schedule.from}");
            print("start schedule Date ${schedule.eventName}");
            if(_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              onPress!(schedule);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(msg),
                  )
              );

            }

          },
        ),
        TextButton(
            onPressed :() {
              Navigator.of(context).pop();
            },
            child: const Text("취소")
        )
      ],
    );
  }
}