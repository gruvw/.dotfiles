// ~/.config/Hyper/.hyper.js

"use strict"
module.exports = {
    config: {
        updateChannel: 'stable',
        fontSize: 13,
        fontFamily: '"Fira Code", monospace',
        fontWeight: 'normal',
        fontWeightBold: 'bold',
        lineHeight: 1,
        letterSpacing: 0,
        cursorColor: 'rgba(255,255,255,0.8)',
        cursorAccentColor: '#000',
        cursorShape: 'BLOCK',
        cursorBlink: true,
        foregroundColor: '#f7f1ff',
        backgroundColor: '#363537',
        selectionColor: 'rgba(123, 216, 143,0.3)',
        borderColor: '#333',
        css: '.xterm-viewport::-webkit-scrollbar-thumb { background-color: #000;}', // .xterm-screen > canvas:nth-child(4) {padding: 2px 5px;}',
        termCSS: '',
        workingDirectory: '',
        showHamburgerMenu: '',
        showWindowControls: true,
        colors: {
            // MONOKAI PRO (spectrum filter) colors
            // No light colors
            black: '#000',
            red: '#fc618d',
            green: '#7bd88f',
            yellow: '#fce566',
            blue: '#fd9353',  // blue is actually orange
            magenta: '#948ae3',  // more like purple
            cyan: '#5ad4e6',
            white: '#f7f1ff',
            lightBlack: '#686868',
            lightRed: '#fc618d',
            lightGreen: '#7bd88f',
            lightYellow: '#fce566',
            lightBlue: '#fd9353',
            lightMagenta: '#948ae3',
            lightCyan: '#5ad4e6',
            lightWhite: '#f7f1ff',
            limeGreen: '#7bd88f',
            lightCoral: '#F08080',
        },
        shell: '/usr/bin/fish',
        shellArgs: ['--login'],
        env: {},
        bell: false,
        scrollback: 99999,
        copyOnSelect: false,
        defaultSSHApp: false,
        quickEdit: false,
        macOptionSelectionMode: 'vertical',
        webGLRenderer: true,
        webLinksActivationKey: 'ctrl',
        disableLigatures: false,
        disableAutoUpdates: false,
    },
    plugins: [],
    localPlugins: [],
    keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
    },
};
