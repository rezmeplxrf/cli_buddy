cd build/web
dhttpd '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin'
dart run ./Users/rezmeplx/Projects/cli_buddy/bin/buddy.dart open --no-launch