#!/bin/sh
cd ..
flutter build linux
flatpak-builder --force-clean --repo=myrepo _flatpak app.sculpting.body.json
flatpak build-bundle myrepo bodysculpting.flatpak app.sculpting.body
cd "$(dirname "$0")"
