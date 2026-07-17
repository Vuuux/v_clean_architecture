DEFINE_FLAGS=--dart-define-from-file=env/sit.json
DEFINE_FLAGS_UAT=--dart-define-from-file=env/uat.json
DEFINE_FLAGS_PRD=--dart-define-from-file=env/prd.json

OBFUSCATE_ANDROID=--obfuscate --split-debug-info=build/app/outputs/flutter-apk/app-build.obfuscate.aab
OBFUSCATE_IOS=--obfuscate --split-debug-info=build/app/outputs/flutter-ios

pub-get:
	cd packages/app_core && flutter pub get
	cd packages/app_ui && flutter pub get
	flutter pub get

storybook:
	flutter run -t packages/app_ui/storybook/main_storybook.dart

# Environment-specific run commands
# Standard development (SIT)
dev:
	flutter run ${DEFINE_FLAGS} --flavor sit

# UAT environment
dev-uat:
	flutter run ${DEFINE_FLAGS_UAT} --flavor uat

# Production environment
dev-prd:
	flutter run ${DEFINE_FLAGS_PRD} --flavor prd

# Manual run with custom config
run-sit:
	flutter run --dart-define-from-file=env/sit.json --flavor sit

unit-test:
ifdef coverage
	rm -f coverage/lcov.info
	rm -rf coverage/html
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html
else
	flutter test
endif

build-android-sit:
	flutter build apk ${OBFUSCATE_ANDROID} --release ${DEFINE_FLAGS} --flavor sit
build-android-uat:
	flutter build apk ${OBFUSCATE_ANDROID} --release ${DEFINE_FLAGS_UAT} --flavor uat
build-android-prd:
	flutter build appbundle ${OBFUSCATE_ANDROID} --release ${DEFINE_FLAGS_PRD} --flavor prd

build-ios-sit:
	flutter build ios ${OBFUSCATE_IOS} --release ${DEFINE_FLAGS} --flavor sit
build-ios-uat:
	flutter build ios ${OBFUSCATE_IOS} --release ${DEFINE_FLAGS_UAT} --flavor uat
build-ios-prd:
	flutter build ios ${OBFUSCATE_IOS} --release ${DEFINE_FLAGS_PRD} --flavor prd

gen:
	dart run build_runner build --delete-conflicting-outputs

gen-assets:
	dart run scripts/generate_assets.dart

check-assets:
	dart run scripts/check_assets.dart

gen-feature:
	chmod +x scripts/generate_feature.sh
	bash scripts/generate_feature.sh

deeplink-android-sit:
	adb shell am start -W -a android.intent.action.VIEW -d "sample.id.example://" localhost.com

deeplink-ios-sit:
	xcrun simctl openurl booted ample.id.example://

ANALYZE_FLAGS=--no-fatal-infos --no-fatal-warnings
# make analyze PATTERN=event
# make analyze PATTERN='(event|mi_test)' Falls back to full project if no match.
NAME?=
PATTERN?=$(NAME)

.PHONY: analyze
analyze:
ifeq ($(strip $(PATTERN)),)
	flutter analyze $(ANALYZE_FLAGS)
else
	@FILES=$$(find lib packages test -type f -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" 2>/dev/null | grep -E "$(PATTERN)" || true); \
	if [ -z "$$FILES" ]; then \
		echo "No non-generated Dart files matched regex '$(PATTERN)'. Analyzing whole project (excluding generated)."; \
		flutter analyze $(ANALYZE_FLAGS) $$(find lib packages test -type f -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" 2>/dev/null); \
	else \
		echo "Analyzing matched non-generated files for regex: $(PATTERN)"; \
		echo "$$FILES" | tr ' ' '\n'; \
		flutter analyze $(ANALYZE_FLAGS) $$FILES; \
	fi
endif

# Usage examples:
# make analyze                -> full project
# make analyze PATTERN=event  -> files whose path matches /event/
# make analyze PATTERN='(event|mi_test)' -> multiple alternatives
# make analyze NAME=event     -> deprecated alias
