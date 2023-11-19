import board

from kb import KMKKeyboard, isRight
from kmk.consts import UnicodeMode

from kmk.keys import KC
from kmk.modules.mouse_keys import MouseKeys
from kmk.modules.layers import Layers
from kmk.modules.capsword import CapsWord
from kmk.modules.oneshot import OneShot
from kmk.modules.combos import Chord, Combos
from kmk.modules.dynamic_sequences import DynamicSequences
from kmk.handlers.sequences import unicode_string_sequence, send_string
from kmk.modules.split import Split, SplitSide, SplitType

# PARAMS

OS_TIMEOUT = 1000
DS_TIMEOUT = 60 * 1000

OS_TAP_TIME = 500
TAP_TIME = 150

MOUSE_MAX_SPEED = 28
MOUSE_ACC_INTERVAL = 24

# SETUP

keyboard = KMKKeyboard()

layers = Layers()
oneshot = OneShot()
combos = Combos()
caps_word = CapsWord()
mouse_keys = MouseKeys()

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

dynamic_sequences = DynamicSequences(timeout=DS_TIMEOUT)

keyboard.unicode_mode = UnicodeMode.LINUX
mouse_keys.max_speed = MOUSE_MAX_SPEED
mouse_keys.acc_interval = MOUSE_ACC_INTERVAL

# Keys

DEG = unicode_string_sequence("°")
MIDP = unicode_string_sequence("·")
HTP = send_string("https://")
AP_T = send_string("'t ")

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

MGC_LAY = KC.LT(5, KC.TAB, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)
SP1_LAY = KC.LT(3, KC.ENTER, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)
SP2_LAY = KC.LT(4, KC.DEL, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)
NUM_LAY = KC.LT(1, KC.BSPC, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)
FUN_LAY = KC.LT(2, KC.DOT, tap_time=TAP_TIME, prefer_hold=True, tap_interrupted=True)

DS_REC = KC.RECORD_SEQUENCE()
DS_STP = KC.STOP_SEQUENCE()
DS_PLA = KC.PLAY_SEQUENCE()
DS_REP = KC.SET_SEQUENCE_REPETITIONS()
DS_INT = KC.SET_SEQUENCE_INTERVAL()

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

# TODO Media keys

keyboard.keymap = [
    # 0: DVORAK
    [
        KC.NO,     KC.RALT,   OS_LGUI,   OS_LALT,   KC.P,      KC.Y,                 KC.F,      KC.G,      KC.C,      KC.R,      KC.L,      KC.NO,
        KC.NO,     KC.A,      KC.O,      KC.E,      KC.U,      KC.I,                 KC.D,      KC.H,      KC.T,      KC.N,      KC.S,      KC.NO,
        KC.NO,     KC.ESC,    KC.Q,      KC.J,      KC.K,      KC.X,                 KC.B,      KC.M,      KC.W,      KC.V,      KC.Z,      KC.NO,
                                         MGC_LAY,   KC.SPC,    SP1_LAY,              OS_LSFT,   NUM_LAY,   OS_LCTL,
    ],

    # 1: Numbers / Symbols 1
    [
        KC.NO,     KC.GRV,    KC.TILD,   KC.DLR,    KC.HASH,    KC.AT,                KC.BSLS,   KC.EXLM,   KC.QUES,   KC.PLUS,   KC.SLSH,   KC.NO,
        KC.NO,     KC.N0,     KC.N1,     KC.N2,     KC.N3,     KC.N4,                KC.MINS,   KC.COMM,   KC.DQUO,   KC.QUOT,   KC.COLN,   KC.NO,
        KC.NO,     KC.N5,     KC.N6,     KC.N7,     KC.N8,     KC.N9,                KC.PIPE,   KC.UNDS,   KC.AMPR,   KC.CIRC,   KC.ASTR,   KC.NO,
                                         KC.EQL,    FUN_LAY,   KC.SCLN,              KC.NO,     KC.TRNS,   KC.NO,
    ],

    # 2: Function / Symbols 2
    [
        KC.NO,     DEG,       MIDP,      KC.F10,    KC.F11,    KC.F12,               KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.PERC,   KC.NO,
        KC.NO,     KC.NO,     KC.F1,     KC.F2,     KC.F3,     KC.F4,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,   KC.NO,
        KC.NO,     KC.F5,     KC.F6,     KC.F7,     KC.F8,     KC.F9,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,
                                         KC.NO,     KC.TRNS,   KC.NO,                KC.NO,     KC.TRNS,   KC.NO
    ],

    # 3: Special keys 1
    [
        KC.NO,     KC.NO,     KC.LABK,   KC.LCBR,   KC.LPRN,   KC.LBRC,              KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.RIGHT,  KC.NO,
        KC.NO,     KC.NO,     KC.RABK,   KC.RCBR,   KC.RPRN,   KC.RBRC,              KC.NO,     KC.LEFT,   KC.NO,     AP_T,      KC.NO,     KC.NO,
        KC.NO,     KC.NO,     KC.NO,     KC.DOWN,   KC.UP,     KC.NO,                KC.INS,    KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,
                                         KC.NO,     KC.NO,     KC.TRNS,              KC.CW,     SP2_LAY,   KC.NO
    ],

    # 4: Special keys 2
    [
        KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.END,    KC.NO,
        KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,                KC.NO,     KC.HOME,   KC.NO,     KC.NO,     KC.NO,     KC.NO,
        KC.NO,     KC.NO,     KC.NO,     KC.PGDN,   KC.PGUP,   KC.NO,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,
                                         KC.NO,     KC.NO,     KC.TRNS,              KC.NO,     KC.TRNS,   KC.NO
    ],

    # 5: Magic / Mouse
    [
        KC.NO,     HTP,       KC.NO,     KC.MS_UP,  KC.NO,     KC.NO,                KC.MB_MMB, KC.NO,     KC.MW_UP,  KC.NO,     KC.NO,     KC.NO,
        KC.NO,     KC.NO,     KC.MS_LT,  KC.MS_DN,  KC.MS_RT,  KC.NO,                KC.NO,     KC.MW_LT,  KC.MW_DN,  KC.MW_RT,  KC.NO,     KC.NO,
        KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,                DS_REP,    DS_REC,    DS_STP,    DS_PLA,    DS_INT,    KC.NO,
                                         KC.TRNS,   KC.NO,     KC.NO,                KC.NO,     KC.MB_LMB, KC.MB_RMB
    ],

    # X: Dummy
    # [, mouse_keys
    #     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,
    #     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,
    #     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,                KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,     KC.NO,
    #                                      KC.NO,     KC.NO,     KC.NO,                KC.NO,     KC.NO,     KC.NO
    # ],
]

# MAIN

keyboard.modules += [dynamic_sequences, mouse_keys, combos, layers, split, caps_word, oneshot]

if __name__ == '__main__':
    keyboard.go()
