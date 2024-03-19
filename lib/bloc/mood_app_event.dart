part of 'mood_app_bloc.dart';

@immutable
sealed class MoodAppEvent {}

class MoodChanged extends MoodAppEvent {
  final bool isDark;

  MoodChanged(this.isDark);
}
