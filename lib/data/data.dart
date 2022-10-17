import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:note_app/data/get_all_notes/get_all_notes.dart';
import 'package:note_app/data/url.dart';
import 'package:note_app/note_model/note_model.dart';

abstract class ApiCalls {
  Future<NoteModel?> createNote(NoteModel value);
  Future<NoteModel?> updateNote(NoteModel value);
  Future<List<NoteModel>?> getAllNote();
  Future<void> deleteNote(String id);
}

class NoteDB extends ApiCalls {
  final dio = Dio(); //creating objects for Dio and URL class
  final url = Url();

  NoteDB() {
    dio.options =
        BaseOptions(baseUrl: url.baseUrl, responseType: ResponseType.plain);
  }

  @override
  Future<NoteModel?> createNote(NoteModel value) async {
    try {
      final _result = await dio.post(url.createNote, data: value.toJson());
      final _resultAsJson = jsonDecode(_result.data);
      return NoteModel.fromJson(_resultAsJson as Map<String, dynamic>);
    } on DioError catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>?> getAllNote() async {
    final _result = await dio.get(url.baseUrl + url.getAllNote);
    if (_result.data != null) {
      final _resultAsJson = jsonDecode(_result.data);
      final getNotesResp = GetAllNotes.fromJson(_resultAsJson);
      return getNotesResp.data;
    } else {
      return [];
    }
  }

  @override
  Future<NoteModel?> updateNote(NoteModel value) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
