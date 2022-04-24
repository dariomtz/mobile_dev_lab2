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
  final String path;

  const RecordingFinished({required this.path});

  @override
  List<Object> get props => [path];
}

class RecordError extends RecordState {}
