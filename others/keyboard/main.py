import board
import digitalio

from kb import KMKKeyboard, isRight
from kmk.consts import UnicodeMode
from storage import getmount

from kmk.keys import KC
from kmk.modules.layers import Layers
from kmk.modules.oneshot import OneShot
from kmk.modules.combos import Chord, Combos
from kmk.handlers.sequences import unicode_string_sequence
from kmk.modules.split import Split, SplitSide, SplitType

# SETUP

keyboard = KMKKeyboard()

layers = Layers()
oneshot = OneShot()
combos = Combos()

split_side = SplitSide.RIGHT if isRight else SplitSide.LEFT

data_pin = board.GP1 if split_side == SplitSide.LEFT else board.GP0
data_pin2 = board.GP0 if split_side == SplitSide.LEFT else board.GP1

split = Split(
    split_side=split_side,
    split_type=SplitType.UART,
    split_flip=False,
    data_pin=data_pin,
    data_pin2=data_pin2
)

keyboard.modules += [oneshot, combos, split, layers]

# Keys

keyboard.unicode_mode = UnicodeMode.LINUX

DEG = unicode_string_sequence("°")

OS_TIMEOUT = 1000
OS_LCTL = KC.OS(KC.LCTL, tap_time=None)
OS_LSFT = KC.OS(KC.LSFT, tap_time=None)
OS_LGUI = KC.OS(KC.LGUI, tap_time=None)
OS_LALT = KC.OS(KC.LALT, tap_time=None)

OS_LCTL_LSFT = KC.OS(KC.LCTL(OS_LSFT), tap_time=None)
OS_LCTL_LALT = KC.OS(KC.LCTL(OS_LALT), tap_time=None)
OS_LCTL_LGUI = KC.OS(KC.LCTL(OS_LGUI), tap_time=None)
OS_LSFT_LALT = KC.OS(KC.LSFT(OS_LALT), tap_time=None)
OS_LSFT_LGUI = KC.OS(KC.LSFT(OS_LGUI), tap_time=None)
OS_LALT_LGUI = KC.OS(KC.LALT(OS_LGUI), tap_time=None)

OS_LCTL_LSFT_LGUI = KC.OS(KC.LCTL(KC.LSFT(OS_LGUI)), tap_time=None)
OS_LCTL_LSFT_LALT = KC.OS(KC.LCTL(KC.LSFT(OS_LALT)), tap_time=None)
OS_LCTL_LALT_LGUI = KC.OS(KC.LCTL(KC.LALT(OS_LGUI)), tap_time=None)
OS_LSFT_LALT_LGUI = KC.OS(KC.LSFT(KC.LALT(OS_LGUI)), tap_time=None)

OS_LCTL_LSFT_LALT_LGUI = KC.OS(KC.LCTL(KC.LSFT(KC.LALT(OS_LGUI))), tap_time=None)

NUM_LAY = KC.LT(1, KC.BSPC, tap_time=200, prefer_hold=True, tap_interrupted=True)
FUN_LAY = KC.LT(2, KC.DOT, tap_time=200, prefer_hold=True)

# Combos

combos.combos = [
    Chord((OS_LCTL, OS_LSFT), OS_LCTL_LSFT, timeout=OS_TIMEOUT),
    Chord((OS_LCTL, OS_LALT), OS_LCTL_LALT, timeout=OS_TIMEOUT),
    Chord((OS_LCTL, OS_LGUI), OS_LCTL_LGUI, timeout=OS_TIMEOUT),
    Chord((OS_LSFT, OS_LALT), OS_LSFT_LALT, timeout=OS_TIMEOUT),
    Chord((OS_LSFT, OS_LGUI), OS_LSFT_LGUI, timeout=OS_TIMEOUT),
    Chord((OS_LALT, OS_LGUI), OS_LALT_LGUI, timeout=OS_TIMEOUT),

    Chord((OS_LCTL, OS_LSFT, OS_LGUI), OS_LCTL_LSFT_LGUI, timeout=OS_TIMEOUT),
    Chord((OS_LCTL, OS_LSFT, OS_LALT), OS_LCTL_LSFT_LALT, timeout=OS_TIMEOUT),
    Chord((OS_LCTL, OS_LALT, OS_LGUI), OS_LCTL_LALT_LGUI, timeout=OS_TIMEOUT),
    Chord((OS_LSFT, OS_LALT, OS_LGUI), OS_LSFT_LALT_LGUI, timeout=OS_TIMEOUT),

    Chord((OS_LCTL, OS_LSFT, OS_LALT, OS_LGUI), OS_LCTL_LSFT_LALT_LGUI, timeout=OS_TIMEOUT),
]

# LAYERS

keyboard.keymap = [
    # 0: DVORAK
    [
        KC.NO,   KC.RALT, OS_LGUI, OS_LALT, KC.P,    KC.Y,                          KC.F,    KC.G,    KC.C,    KC.R,   KC.L,  KC.NO,
        KC.NO,   KC.A,    KC.O,    KC.E,    KC.U,    KC.I,                          KC.D,    KC.H,    KC.T,    KC.N,   KC.S,  KC.NO,
        KC.NO,   KC.ESC,  KC.Q,    KC.J,    KC.K,    KC.X,                          KC.B,    KC.M,    KC.W,    KC.V,   KC.Z,  KC.NO,
                                            KC.TAB,  KC.SPC,  KC.ENTER,    OS_LSFT, NUM_LAY, OS_LCTL,
    ],

    # 1: Numbers / Symbols 1
    [
        KC.NO,   KC.GRV,  KC.LT,   KC.LCBR, KC.LPRN, KC.LBRC,                       KC.COMM, KC.EXLM, KC.QUES, KC.DQUO, KC.QUOT, KC.NO,
        KC.NO,   KC.N0,   KC.N1,   KC.N2,   KC.N3,   KC.N4,                         KC.PLUS, KC.MINS, KC.ASTR, KC.SLSH, KC.COLN, KC.NO,
        KC.NO,   KC.N5,   KC.N6,   KC.N7,   KC.N8,   KC.N9,                         KC.BSLS, KC.UNDS, KC.CIRC, KC.AMPR, KC.PIPE, KC.NO,
                                            KC.EQL,  FUN_LAY, KC.SCLN,     KC.NO,   KC.TRNS, KC.NO,
    ],

    # 2: Function / Symbols 2
    [
        KC.NO,   DEG,     KC.GT,   KC.RCBR, KC.RPRN, KC.RBRC,                       KC.F10,  KC.TILD, KC.NO,   KC.NO,   KC.NO,   KC.NO,
        KC.NO,   KC.NO,   KC.F1,   KC.F2,   KC.F3,   KC.F4,                         KC.F11,  KC.AT,   KC.DLR,  KC.PERC, KC.HASH, KC.NO,
        KC.NO,   KC.F5,   KC.F6,   KC.F7,   KC.F8,   KC.F9,                         KC.F12,  KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.NO,
                                            KC.NO,   KC.TRNS,   KC.NO,     KC.NO,   KC.TRNS, KC.NO
    ]
]

# MAIN

if __name__ == '__main__':
    keyboard.go()
