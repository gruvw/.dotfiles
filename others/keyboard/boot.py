import board

from kmk.bootcfg import bootcfg

a = bootcfg(
    sense=board.GP18,
    mouse=True,
    nkro=True,
)
print(a)
