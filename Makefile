ROOT := $(shell git rev-parse --show-toplevel)
FVM := $(ROOT)/.fvm/flutter_sdk/bin/flutter
FLUTTER := $(shell which flutter)
FLUTTER_BIN_DIR := $(shell dirname $(FLUTTER))
FLUTTER_DIR := $(FLUTTER_BIN_DIR:/bin=)
DART := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dart


buildRunner:
	@echo "Run Pub build runner"
	@flutter packages pub run build_runner build --delete-conflicting-outputs

cacheCleanMchip:
	@echo "🧹 Cleaning caches of the app🧹"
	@rm -rf build && rm -rf ios/Pods && rm -rf ios/Podfile.lock && rm -rf .pub-cache/hosted/pub.dartlang.org/ && pod cache clean --all && ${FLUTTER} clean && ${FLUTTER} pub get && cd ios && arch -x86_64 pod install
