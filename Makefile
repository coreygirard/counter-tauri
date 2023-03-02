dev-build:
	elm make src/Main.elm --output=public/main.js
	cargo tauri build

elm-build:
	elm make src/Main.elm --output=public/main.js
