# ~/.config/fish/exports.fish

# == Android / Flutter ==
set ANDROID_HOME "$HOME/Android/Sdk"
set PATH "$ANDROID_HOME/tools:$PATH"
set PATH "$ANDROID_HOME/emulator:$PATH"
set PATH "$ANDROID_HOME/platform-tools:$PATH"
set PATH "$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

export CHROME_EXECUTABLE="/opt/brave.com/brave/brave-browser"

# == Others ==
set PATH "$HOME/pathed:$PATH"

