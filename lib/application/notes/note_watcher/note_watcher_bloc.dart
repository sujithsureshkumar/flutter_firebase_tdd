import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;
  StreamSubscription<Either<NoteFailure, KtList<Note>>>? noteStreamSubscription;
  NoteWatcherBloc(this._noteRepository) : super(const _Initial()) {
    on<NoteWatcherEvent>((event, emit) async {
      await event.map(watchAllStarted: (e) async {
        emit(const NoteWatcherState.loadInProgress());
        if (noteStreamSubscription != null) {
          await noteStreamSubscription!.cancel();
        }

        noteStreamSubscription = _noteRepository.watchAll().listen(
              (failureOrNotes) =>
                  add(NoteWatcherEvent.notesReceived(failureOrNotes)),
            );
      }, watchUncompletedStarted: (e) async {
        emit(const NoteWatcherState.loadInProgress());
        if (noteStreamSubscription != null) {
          await noteStreamSubscription!.cancel();
        }
        noteStreamSubscription = _noteRepository.watchUncompleted().listen(
              (failureOrNotes) =>
                  add(NoteWatcherEvent.notesReceived(failureOrNotes)),
            );
      }, notesReceived: (e) {
        emit(e.failureOrNotes.fold(
          (f) => NoteWatcherState.loadFailure(f),
          (notes) => NoteWatcherState.loadSuccess(notes),
        ));
      });
    });
  }
  @override
  Future<void> close() async {
    if (noteStreamSubscription != null) {
      await noteStreamSubscription!.cancel();
    }
    return super.close();
  }
}
