# ~/.config/fish/exports.fish

# == Android / Flutter ==
set ANDROID_HOME "$HOME/Android/Sdk"
set PATH "$ANDROID_HOME/tools:$PATH"
set PATH "$ANDROID_HOME/emulator:$PATH"
set PATH "$ANDROID_HOME/platform-tools:$PATH"
set PATH "$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

export PLAYDATE_SDK_PATH="$HOME/Applications/PlaydateSDK-2.4.0/"
export CHROME_EXECUTABLE="/opt/brave.com/brave/brave-browser"

# == Others ==
set PATH "$HOME/pathed:$PATH"
# set PATH "$HOME/intelFPGA_lite/20.1/quartus/bin:$PATH"
set PATH "$HOME/intelFPGA_lite/20.1/modelsim_ase/bin:$PATH"
set PATH "$HOME/intelFPGA_lite/21.1/quartus/bin:$PATH"
set PATH "$HOME/.local/share/coursier/bin:$PATH"
set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/Android/Sdk/cmdline-tools/latest/tools/bin:$PATH"
set PATH "$HOME/Applications/PlaydateSDK-2.4.0/bin:$PATH"
set PATH "$HOME/Applications/Arduino/bin:$PATH"
set PATH "$HOME/Applications/bin:$PATH"
set PATH "$HOME/.pub-cache/bin:$PATH"
set PATH "/usr/local/go/bin:$PATH"

set NAME "LUCAS"
