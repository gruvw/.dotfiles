import board
import digitalio

from kb import KMKKeyboard, isRight
from kmk.consts import UnicodeMode

from kmk.keys import KC
from kmk.modules.tapdance import TapDance
from kmk.modules.layers import Layers
from kmk.modules.capsword import CapsWord
from kmk.modules.oneshot import OneShot
from kmk.modules.combos import Chord, Combos
from kmk.handlers.sequences import unicode_string_sequence
from kmk.modules.split import Split, SplitSide, SplitType

# PARAMS

OS_TIMEOUT = 1000
OS_TAP_TIME = 1000
TAP_TIME = 200

# SETUP

keyboard = KMKKeyboard()

layers = Layers()
oneshot = OneShot()
combos = Combos()
caps_word = CapsWord()

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

# Keys

keyboard.unicode_mode = UnicodeMode.LINUX

DEG = unicode_string_sequence("°")

OS_LCTL = KC.OS(KC.LCTL, tap_time=OS_TAP_TIME)
OS_LSFT = KC.OS(KC.LSFT, tap_time=OS_TAP_TIME)
OS_LGUI = KC.OS(KC.LGUI, tap_time=OS_TAP_TIME)
OS_LALT = KC.OS(KC.LALT, tap_time=OS_TAP_TIME)

OS_LCTL_LSFT = KC.OS(KC.LCTL(OS_LSFT), tap_time=OS_TAP_TIME)
OS_LCTL_LALT = KC.OS(KC.LCTL(OS_LALT), tap_time=OS_TAP_TIME)
OS_LCTL_LGUI = KC.OS(KC.LCTL(OS_LGUI), tap_time=OS_TAP_TIME)
OS_LSFT_LALT = KC.OS(KC.LSFT(OS_LALT), tap_time=OS_TAP_TIME)
OS_LSFT_LGUI = KC.OS(KC.LSFT(OS_LGUI), tap_time=OS_TAP_TIME)
OS_LALT_LGUI = KC.OS(KC.LALT(OS_LGUI), tap_time=OS_TAP_TIME)

OS_LCTL_LSFT_LGUI = KC.OS(KC.LCTL(KC.LSFT(OS_LGUI)), tap_time=OS_TAP_TIME)
OS_LCTL_LSFT_LALT = KC.OS(KC.LCTL(KC.LSFT(OS_LALT)), tap_time=OS_TAP_TIME)
OS_LCTL_LALT_LGUI = KC.OS(KC.LCTL(KC.LALT(OS_LGUI)), tap_time=OS_TAP_TIME)
OS_LSFT_LALT_LGUI = KC.OS(KC.LSFT(KC.LALT(OS_LGUI)), tap_time=OS_TAP_TIME)

OS_LCTL_LSFT_LALT_LGUI = KC.OS(KC.LCTL(KC.LSFT(KC.LALT(OS_LGUI))), tap_time=OS_TAP_TIME)

NUM_LAY = KC.LT(1, KC.BSPC, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)
FUN_LAY = KC.LT(2, KC.DOT, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)
SPC_LAY = KC.LT(3, KC.SPC, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)

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
        KC.NO,   KC.RALT, OS_LGUI, OS_LALT, KC.P,    KC.Y,                          KC.F,    KC.G,    KC.C,    KC.R,    KC.L,      KC.NO,
        KC.NO,   KC.A,    KC.O,    KC.E,    KC.U,    KC.I,                          KC.D,    KC.H,    KC.T,    KC.N,    KC.S,      KC.NO,
        KC.NO,   KC.ESC,  KC.Q,    KC.J,    KC.K,    KC.X,                          KC.B,    KC.M,    KC.W,    KC.V,    KC.Z,      KC.NO,
                                            KC.TAB,  SPC_LAY,  KC.ENTER,   OS_LSFT, NUM_LAY, OS_LCTL,
    ],

    # 1: Numbers / Symbols 1
    [
        KC.NO,   KC.GRV,  KC.RABK, KC.RCBR, KC.RPRN, KC.RBRC,                       KC.COMM, KC.EXLM, KC.QUES, KC.DQUO, KC.QUOT,  KC.NO,
        KC.NO,   KC.N0,   KC.N1,   KC.N2,   KC.N3,   KC.N4,                         KC.PLUS, KC.MINS, KC.ASTR, KC.SLSH, KC.COLN,  KC.NO,
        KC.NO,   KC.N5,   KC.N6,   KC.N7,   KC.N8,   KC.N9,                         KC.BSLS, KC.UNDS, KC.CIRC, KC.AMPR, KC.PIPE,  KC.NO,
                                            KC.EQL,  FUN_LAY, KC.SCLN,     KC.NO,   KC.TRNS, KC.NO,
    ],

    # 2: Function / Symbols 2
    [
        KC.NO,   DEG,     KC.NO,   KC.F10,  KC.F11,  KC.F12,                        KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.NO,    KC.NO,
        KC.NO,   KC.NO,   KC.F1,   KC.F2,   KC.F3,   KC.F4,                         KC.TILD, KC.AT,   KC.DLR,  KC.PERC, KC.HASH,  KC.NO,
        KC.NO,   KC.F5,   KC.F6,   KC.F7,   KC.F8,   KC.F9,                         KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.NO,    KC.NO,
                                            KC.NO,   KC.TRNS,   KC.NO,     KC.NO,   KC.TRNS, KC.NO
    ],

    # 3: Special keys
    [
        KC.NO,   KC.NO,   KC.LABK, KC.LCBR, KC.LPRN, KC.LBRC,                       KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.RIGHT, KC.NO,
        KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.NO,                         KC.NO,   KC.LEFT, KC.NO,   KC.NO,   KC.NO,    KC.NO,
        KC.NO,   KC.NO,   KC.NO,   KC.DOWN, KC.UP,   KC.NO,                         KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.NO,    KC.NO,
                                            KC.NO,   KC.TRNS,   KC.NO,     KC.CW,   KC.NO, KC.NO
    ]
]

# MAIN

keyboard.modules += [oneshot, combos, split, layers, caps_word]

if __name__ == '__main__':
    keyboard.go()
