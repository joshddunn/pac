# PAC 

PAC is a convenient project structure for making games in pico-8.

## Guide

Make sure ruby and pico-8 are installed on your machine.

Clone this repository to the directory used by pico-8.

You must include function identifiers in your `PACFILE` in order to use them. See the `Library` section to learn more about the functions.

To compile your project into the `game.p8` file, run

    ruby pac.rb

If you have `fswatch` installed, use the command

    fswatch -o game/ | xargs -n1 ruby pac.rb

to automatially watch for saved changes in the `game/` folder and then compile your game.

## File Structure

The files are compiled in the order:

  - Included PAC library functions
  - Globals (found in `game/globals.p8`)
  - User defined functions (found in `game/functions/`)
  - Update loop (found in `game/update.p8`)
  - Draw loop (found in `game/draw.p8`)
  - PICO-8 generated data (found in `game/draw.p8`)

## Library

### pac.mod(a, b)

Activated by including `mod` in your `PACFILE`.

Calculates `a % b`.
