# Deprecation
Talisman will no longer be supported due to the existance of [Amulet](https://github.com/frostice482/amulet)

Amulet is a fork of Talisman that fixes many of the issues present in Talisman so please use Amulet instead

# Talisman
A mod for Balatro that increases the score cap from ~10^308 to ~10{1000}10, allowing for endless runs to go past "naneinf" and Ante 39, and additionally adds the option to remove the long animations that come with these scores.

The "BigNum" representation used by Talisman is a modified version of [this](https://github.com/veprogames/lua-big-number) library by veprogames.
The "OmegaNum" representation used by Talisman is a port of [OmegaNum.js](https://github.com/Naruyoko/OmegaNum.js/blob/master/OmegaNum.js) by [Mathguy23](https://github.com/Mathguy23)

## Installation
Talisman requires [Lovely](https://github.com/ethangreen-dev/lovely-injector) to be installed in order to be loaded by Balatro.

## Limitations
- High scores will not be saved to your profile (this is to prevent your profile save from being incompatible with an unmodified instance of Balatro)
- Savefiles created/opened with Talisman aren't backwards-compatible with unmodified versions of Balatro.
- Depending on the amount of retriggers, there may be lag when computing a score with Talisman.
- The largest ante before the new limit is approximately 1e300 due to BigNumber antes not being supported.
- When using Talisman with other mods because of how Talisman works, comparison operations with numbers used by scoring will not work by default, a lot of interactions without explicit support will break with Talisman enabled.
- [Luajit2 (Balatro Discord)](https://discord.com/channels/1116389027176787968/1336473631483760791) can be used to mitigate some of the issues but it will not fix everything.
