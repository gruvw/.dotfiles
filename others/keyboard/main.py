import board
import digitalio

from kb import KMKKeyboard, isRight
from storage import getmount

from kmk.keys import KC
from kmk.modules.layers import Layers
from kmk.modules.split import Split, SplitSide, SplitType

keyboard = KMKKeyboard()
# keyboard.tap_time = 100

layers = Layers()

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
keyboard.modules = [layers, split]

keyboard.keymap = [
    [  # DVORAK
        KC.NO,   KC.NO,   KC.NO,   KC.NO,   KC.P,    KC.Y,                          KC.F,    KC.G,    KC.C,    KC.R,   KC.L,  KC.NO,
        KC.NO,   KC.A,    KC.O,    KC.E,    KC.U,    KC.I,                          KC.D,    KC.H,    KC.T,    KC.N,   KC.S,  KC.NO,
        KC.NO,   KC.Z,    KC.Q,    KC.J,    KC.K,    KC.X,                          KC.B,    KC.M,    KC.W,    KC.V,   KC.Z,  KC.NO,
                                            KC.TAB,  KC.SPC,  KC.ENTER,     KC.NO,  KC.BSPC, KC.NO,
    ],
]

if __name__ == '__main__':
    keyboard.go()
