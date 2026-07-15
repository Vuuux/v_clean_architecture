import 'package:v_clean_architecture/domain/repositories/repositories.dart';

abstract class ProfileInteractor {
  Future<void> sample();
}

final class ProfileInteractorImpl implements ProfileInteractor {
  ProfileInteractorImpl({required ProfileRepository repository})
    : _repository = repository;

  final ProfileRepository _repository;

  @override
  Future<void> sample() {
    return _repository.sample();
  }
}
