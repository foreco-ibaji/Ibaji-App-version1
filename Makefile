ROOT := $(shell git rev-parse --show-toplevel)
FVM := $(ROOT)/.fvm/flutter_sdk/bin/flutter
FLUTTER := $(shell which flutter)
FLUUTER_BIN_DIR := $(shell dirname $(FLUTTER))
FLUTTER_DIR := $(FLUTTER_BIN_DIR:/bin=)
DART := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dart


buildRunner:
	@echo "Run Pub build runner"
	@dart run build_runner build --delete-conflicting-outputs
