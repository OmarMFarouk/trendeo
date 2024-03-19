import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'mood_app_event.dart';

class MoodAppBloc extends Bloc<MoodAppEvent, ThemeMode> {
  MoodAppBloc() : super(ThemeMode.light) {
    on<MoodChanged>((event, emit) {
      emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
    });
  }
}
