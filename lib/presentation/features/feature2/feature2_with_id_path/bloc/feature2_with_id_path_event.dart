part of 'feature2_with_id_path_bloc.dart';

abstract class Feature2WithIdPathEvent {
  const Feature2WithIdPathEvent();
}

class Feature2WithIdPathStarted extends Feature2WithIdPathEvent {
  Feature2WithIdPathStarted({required this.id});
  final String id;
}
