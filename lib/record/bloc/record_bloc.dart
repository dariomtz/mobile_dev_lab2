import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_dev_lab2/data/song.dart';
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
    on<CleanRecordingEvent>(cleanRecording);
  }

  FutureOr<void> cleanRecording(event, emit) async {
    emit(RecordInitial());
  }

  Future<void> startRecording(event, emit) async {
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
    try {
      emit(RecordLoading());
      final String? path = await recorder.stop();
      if (path == null) {
        emit(RecordError());
        return;
      }
      RecognizedSongData? songData = await musicRepo.recognizeSong(path);
      if (songData != null) {
        emit(RecordingFinished(songData: songData));
      } else {
        emit(RecordingFailedRecognition());
      }
    } catch (e) {
      emit(RecordError());
    }
  }
}
