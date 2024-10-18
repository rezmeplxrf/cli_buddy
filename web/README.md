# Test Wasm
cd ./build/web
dhttpd '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin'

# Run server
dart run /Users/rezmeplx/Projects/cli_buddy/bin/buddy.dart open --no-launch


# Build web for cli_buddy
<!-- flutter build web --wasm --base-href "/packages/cli_buddy/lib/assets/web/"  -->
flutter build web --wasm


# Deploy to Firebase
firebase deploy

# Save it to Google Drive
cd ./build
zip -r web.zip web


# Generating doc
dart doc .
# View doc
dart pub global activate dhttpd
dart pub global run dhttpd --path doc/api

https://buddy-chat-2461c.web.app/



## TODO:

1. support Ollama



2. Add a button for making file with the code block to local
3. Add a button for making a file and run it and return the result/error in the code block via local env or docker
4. Add a button to upload a file and keep info of file path and parse the file to pass it to API


## Idea
1.  editController를 사용해서 자동 완성(자동완성도 숏컷 설정해서 바로 부르기)한다음 undo 메소드(숏컷 키를 설정)를 사용해서 자동완성을 취소하기