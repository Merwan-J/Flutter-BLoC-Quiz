import '../../application/quiz_data/quiz_data_event.dart';
import '../../application/quiz_data/quiz_data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../infrastructure/quiz/quiz_repo.dart';

class QuizDataBloc extends Bloc<QuizDataEvent, QuizDataState> {
  final QuizDataRepository repository;

  QuizDataBloc({required this.repository}) : super(Loading()) {
    on<DataRequested>((event, emit) async {
      emit(Loading());
      try {
        bool result = await checkConnectivity();
        if (result) {
          final data = await repository.getData();
          emit(Success(data));
        } else {
          emit(Error("No internet connection. Try again later."));
        }
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }

  Future<bool> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
