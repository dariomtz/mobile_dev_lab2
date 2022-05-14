part of 'record_bloc.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordInitial extends RecordState {}

class RecordLoading extends RecordState {}

class Recording extends RecordState {}

class RecordingFinished extends RecordState {
  final RecognizedSongData songData;

  const RecordingFinished({required this.songData});

  @override
  List<Object> get props => [songData];
}

class RecordingFailedRecognition extends RecordState {}

class RecordError extends RecordState {}
