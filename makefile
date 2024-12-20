gen:
	flutter pub run build_runner build --delete-conflicting-outputs

icon:
	flutter pub run flutter_launcher_icons:main

init_res:
	dart pub global activate flutter_assets_generator

format:
	dart format . --line-length 100

res:
	fgen --output lib/components/resources.g.dart --no-watch --no-preview; \
    mingw32-make format

loc:
	flutter gen-l10n
	mingw32-make format