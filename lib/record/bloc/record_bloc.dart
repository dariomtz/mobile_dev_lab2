import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_dev_lab2/repositories/music_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final recorder = Record();
  final musicRepo = MusicRepository();

  RecordBloc() : super(RecordInitial()) {
    on<StartRecordingEvent>(startRecording);
    on<StopRecordingEvent>(stopRecording);
  }

  Future<void> startRecording(event, emit) async {
    emit(RecordLoading());
    try {
      if (await recorder.hasPermission()) {
        Directory temp = await getTemporaryDirectory();
        String path = '${temp.path}/file.m4a';
        await recorder.start(
          path: path,
        );
        bool isRecording = await recorder.isRecording();
        if (isRecording) {
          emit(Recording());
        }
      }
    } catch (e) {
      emit(RecordError());
    }
  }

  Future<void> stopRecording(event, emit) async {
    emit(RecordLoading());
    final String? path = await recorder.stop();
    if (path == null) {
      emit(RecordError());
    } else {
      print(await musicRepo.recognizeSong(path));
      emit(RecordingFinished(path: path));
    }
  }
}
