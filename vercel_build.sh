#!/bin/bash

set -e

git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter

export PATH="$PATH:$HOME/flutter/bin"

flutter config --enable-web
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build web --release