import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:date_field/date_field.dart';
import 'dart:developer';

class ScheduleForm extends  StatelessWidget{
  late Schedule schedule;

  ScheduleForm({
    required this.schedule,
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

                    // controller: formController['eventName'],
                    decoration: const InputDecoration(hintText : "일정 제목"),
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
                      if(e?.hour == null && e == null){
                        return "시작시간을 선택해주세요.";
                      }
                      if(schedule.to.difference(e!).inMinutes < 0){
                        return "종료시간 이전으로 선택해주세요.";
                      }

                      return null;
                    },
                    onDateSelected: (DateTime value) {
                      schedule.setFrom(value);

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
                      if(e?.hour == null){
                        return "종료시간을 선택해주세요.";
                      }
                      if(e!.difference(schedule.from).inMinutes < 0){
                        return "시작시간 이후로 선택해주세요.";
                      }
                      return null;
                     return (e?.day ?? 0) == 1 ? 'Please not the first day' : null;
                    },
                    onDateSelected: (DateTime value) {
                      schedule.setTo(value);
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
            if(_formKey.currentState!.validate()) {

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