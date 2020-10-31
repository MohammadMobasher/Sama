import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/BloC/Pagination/PaginationEvent.dart';
import 'package:sama/BloC/Pagination/PaginationState.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  @override
  PaginationState get initialState => PaginationStateMessage();

  @override
  Stream<PaginationState> mapEventToState(PaginationEvent event) async* {
    if (event is PaginationEventMessage) {
      yield PaginationStateMessage();
    } else if (event is PaginationEventProfile) {
      yield PaginationStateProfile();
    } else if (event is SplashEventMessage) {
      yield SplashStateMessage();
    } else if (event is PaginationEventAboutUs) {
      yield PaginationStateAboutUs();
    }
  }
}
