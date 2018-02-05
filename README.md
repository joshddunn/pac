# PAC 

PAC is a convenient project structure for making games in pico-8.

## Guide

Make sure ruby and pico-8 are installed on your machine.

Clone this repository to the directory used by pico-8.

You must include function identifiers in your `PACFILE` in order to use them. See the `Library` section to learn more about the functions.

To compile your project into the `game.p8` file, run

    ruby pac.rb compile

If you have `fswatch` installed, use the command

    fswatch -o game/ | xargs -n1 ruby pac.rb compile

to automatially watch for saved changes in the `game/` folder and then compile your game.

## File Structure

The files are compiled in the order:

  - Config (found in `game/config.p8`)
  - Included PAC library functions
  - User defined functions (found in `game/functions/`)
  - Sounds (found in `game/sounds.p8`)
  - Globals (found in `game/globals.p8`)
  - PICO-8 generated data

## Modes

The draw and update functions are organized into modes, which are controlled by the global `mode` variable. If you have the mode `game` make sure that the functions `draw.game()` and `update.game()` exist. These functions can be placed in the `game/functions/draw/` and `game/functions/update/` folders, respectively.

To generate a new mode you can run 

    ruby pac.rb generate mode mode_name

and to destroy a mode you can run

    ruby pac.rb destroy mode mode_name

## Buttons and Colors

Objects have been created for `buttons` and `colors` since they remain constant and the corresponding codes are hard to remember. For example, `buttons.left` returns 0 and `colors.red` returns 8.

## Library

### pac.mod(a, b)

Activated by including `mod` in your `PACFILE`.

Calculates `a % b`.

### pac.print(string, x, y, color)

Activated by including `print` in your `PACFILE`.

At first glace, this looks very similar to the pico-8 print function.

However, `x` accepts `left`, `center`, and `right` as arguments, and `y` accepts `top`, `middle`, and `bottom` as arguments.

If color is `nil`, it defaults to `6` (light grey).

### pac.length(e)

Activated by including `length` in your `PACFILE`.

Returns the length of an object or string.
