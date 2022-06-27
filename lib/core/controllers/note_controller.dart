import 'package:flutter/material.dart';
import 'package:note_app_flutter/core/db/db_helper.dart';
import 'package:note_app_flutter/core/models/note_model.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final noteList = [].obs;
  var batteryLevel = 'Unknown battery level.'.obs ;
  @override
  void onReady() {
    getNotes();
    super.onReady();
  }

  setBatteryValue(value) {
    print('WW $value');
    batteryLevel=value;
  }

  Future<void> addNote({required Note note}) async {
    await DBHelper.insert(note);
    getNotes();
  }

  Future<void> getNotes() async {
    List<Map<String, dynamic>> notes = await DBHelper.query();
    noteList.assignAll(notes.map((data) => Note.fromJson(data)).toList());
  }

  Future<void> deleteNote({required Note note}) async {
    await DBHelper.delete(note);
    getNotes();
  }

  Future<void> updateNote({required Note note}) async {
    await DBHelper.update(note);
    getNotes();
  }
}
