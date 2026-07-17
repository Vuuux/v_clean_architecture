#!/bin/bash

# Prompt for the feature name
echo -e "\033[0;33mEnter the feature name (PascalCase):\033[0m"
read -p "" feature_name

if [[ -z "$feature_name" ]]; then
  echo -e "\033[0;31mError: Feature name cannot be empty. Exiting.\033[0m"
  exit 1
fi


# Convert feature name to snake_case
snake_case_feature_name=$(echo "$feature_name" | sed -E 's/([A-Z])/_\1/g' | tr '[:upper:]' '[:lower:]' | sed 's/^_//')

# Define paths
base_path="lib/presentation/features/$snake_case_feature_name"
bloc_path="$base_path/bloc"
interactor_path="lib/domain/interactors"
domain_repository_path="lib/domain/repositories"
data_repository_path="lib/data/repositories_impl"
data_remote_path="lib/data/sources/remote"


# Create directories
mkdir -p "$bloc_path"

echo -e "\033[0;33mCreate data flow? (yes/no):\033[0m"
read -p "" has_data_flow

if [[ "$has_data_flow" == "yes" || "$has_data_flow" == "y" ]]; then
echo -e "\033[0;36mCreating domain and data...\033[0m"
# Create and write to {feature_name}_interactor.dart
cat > "${interactor_path}/${snake_case_feature_name}_interactor.dart" <<EOL
import 'package:v_clean_architecture/domain/domain.dart';

abstract class ${feature_name}Interactor {
  Future<void> sample();
}

final class ${feature_name}InteractorImpl implements ${feature_name}Interactor {
  ${feature_name}InteractorImpl({required ${feature_name}Repository repository})
    : _repository = repository;

  final ${feature_name}Repository _repository;

  @override
  Future<void> sample() {
    return _repository.sample();
  }
}
EOL

# Append to interactors.dart barrel file if it doesn't already export it
if ! grep -q "./${snake_case_feature_name}_interactor.dart" "${interactor_path}/interactors.dart"; then
  echo "export './${snake_case_feature_name}_interactor.dart';" >> "${interactor_path}/interactors.dart"
  sort "${interactor_path}/interactors.dart" -o "${interactor_path}/interactors.dart"
fi

# Create and write to {feature_name}_repository.dart
cat > "${domain_repository_path}/${snake_case_feature_name}_repository.dart" <<EOL
import 'package:v_clean_architecture/domain/entities/entities.dart';

abstract class ${feature_name}Repository {
  Future<void> sample();
}
EOL

if ! grep -q "./${snake_case_feature_name}_repository.dart" "${domain_repository_path}/repositories.dart"; then
  echo "export './${snake_case_feature_name}_repository.dart';" >> "${domain_repository_path}/repositories.dart"
  sort "${domain_repository_path}/repositories.dart" -o "${domain_repository_path}/repositories.dart"
fi

# Create and write to {feature_name}_repository_impl.dart
cat > "${data_repository_path}/${snake_case_feature_name}_repository_impl.dart" <<EOL
import 'package:v_clean_architecture/data/sources/remote/remote.dart';
import 'package:v_clean_architecture/domain/domain.dart';

final class ${feature_name}RepositoryImpl implements ${feature_name}Repository {
  ${feature_name}RepositoryImpl({required ${feature_name}RemoteSource remoteSource})
    : _remoteSource = remoteSource;

  final ${feature_name}RemoteSource _remoteSource;

  @override
  Future<void> sample() {
    return _remoteSource.sample();
  }
}
EOL

if ! grep -q "./${snake_case_feature_name}_repository_impl.dart" "${data_repository_path}/repositories_impl.dart"; then
  echo "export './${snake_case_feature_name}_repository_impl.dart';" >> "${data_repository_path}/repositories_impl.dart"
  sort "${data_repository_path}/repositories_impl.dart" -o "${data_repository_path}/repositories_impl.dart"
fi

# Create and write to {feature_name}_remote_source.dart
mkdir -p "$data_remote_path"
cat > "${data_remote_path}/${snake_case_feature_name}_remote_source.dart" <<EOL
import 'package:app_core/app_core.dart';

class _${feature_name}Api {
  static const String path = '/v1/${snake_case_feature_name}';
}

abstract class ${feature_name}RemoteSource {
  Future<void> sample();
}

final class ${feature_name}RemoteSourceImpl implements ${feature_name}RemoteSource {
  ${feature_name}RemoteSourceImpl({required BaseHttpClient client}) : _client = client;

  final BaseHttpClient _client;

  @override
  Future<void> sample() async {
    // API call
  }
}
EOL

if ! grep -q "./${snake_case_feature_name}_remote_source.dart" "${data_remote_path}/remote.dart"; then
  echo "export './${snake_case_feature_name}_remote_source.dart';" >> "${data_remote_path}/remote.dart"
  sort "${data_remote_path}/remote.dart" -o "${data_remote_path}/remote.dart"
fi

fi

echo -e "\033[0;36mCreating presentation...\033[0m"
# Create and write to {feature_name}_page.dart
cat > "$base_path/${snake_case_feature_name}_page.dart" <<EOL
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/${snake_case_feature_name}_bloc.dart';
import './${snake_case_feature_name}_screen.dart';

final class ${feature_name}PageArguments {
  ${feature_name}PageArguments();
}

final class ${feature_name}Page extends StatelessWidget {
  const ${feature_name}Page({
    super.key,
    this.arguments,
  });

  final ${feature_name}PageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${feature_name}Bloc.initialize(),
      child: const ${feature_name}Screen(),
    );
  }
}
EOL

# Create and write to {feature_name}_screen.dart
cat > "$base_path/${snake_case_feature_name}_screen.dart" <<EOL
import 'package:flutter/material.dart';

final class ${feature_name}Screen extends StatelessWidget {
  const ${feature_name}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is the ${feature_name} Screen'),
      ),
    );
  }
}
EOL

# Create and write to {feature_name}_bloc.dart
cat > "$bloc_path/${snake_case_feature_name}_bloc.dart" <<EOL
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '${snake_case_feature_name}_event.dart';
part '${snake_case_feature_name}_state.dart';

final class ${feature_name}Bloc extends Bloc<${feature_name}Event, ${feature_name}State> {
  ${feature_name}Bloc() : super(${feature_name}Initial()) {
    on<${feature_name}Started>(_on${feature_name}Started);
  }

  factory ${feature_name}Bloc.initialize() {
    return ${feature_name}Bloc();
  }

  Future<void> _on${feature_name}Started(
    ${feature_name}Started event,
    Emitter<${feature_name}State> emit,
  ) async {
    emit(${feature_name}StartSuccess());
  }
}
EOL

# Create and write to {feature_name}_state.dart
cat > "$bloc_path/${snake_case_feature_name}_state.dart" <<EOL
part of '${snake_case_feature_name}_bloc.dart';

abstract class ${feature_name}State extends Equatable {
  const ${feature_name}State();

  @override
  List<Object?> get props => [];
}

class ${feature_name}Initial extends ${feature_name}State {}

class ${feature_name}StartSuccess extends ${feature_name}State {}
EOL

# Create and write to {feature_name}_event.dart
cat > "$bloc_path/${snake_case_feature_name}_event.dart" <<EOL
part of '${snake_case_feature_name}_bloc.dart';

abstract class ${feature_name}Event {
  const ${feature_name}Event();
}

class ${feature_name}Started extends ${feature_name}Event {
  ${feature_name}Started();
}
EOL

echo -e "\033[0;32mFeature '$feature_name' created successfully!\033[0m"
echo -e "\033[0;33mReminder: Don't forget to register your new RemoteSource, Repository, and Interactor in lib/app/app_dependency_injection.dart\033[0m"
