# TI-83 PCE Doom-like Game

This project is an attempt to create a Doom-like game for the TI-83 PCE calculator, written in eZ80 assembly language.

<!-- The game aims to bring the classic first-person shooter experience to the calculator platform. -->

<!-- ## Project Structure

The main source code for the game is located in the `main.asm` file. This file contains the assembly instructions that control the game's logic and rendering. -->

<!-- ## Features

-   Custom palette creation: The game starts by creating a 1555 color palette for the LCD display.
-   Screen mode control: The game controls the LCD display mode, switching between 8bpp and 16bpp modes as needed.
-   Memory management: The game uses the TI-83's VRAM for storing game data, and includes routines for clearing VRAM and setting memory values.
-   Key input handling: The game includes a simple input handling loop that waits for the user to press the Enter key. -->

## Building the Project

To build this project, you will need an eZ80 assembler, like `fasmg`.
You can compile the project by running the following command:

```bash
# linux
./fasmg-linux main.asm
# windows
fasmg.exe     main.asm
# macos
./fasmg-macos main.asm
```

You could find the latest version of `fasmg`, and the **include** files [here](https://github.com/CE-Programming/asm-docs).
The source code includes several include files, that define various constants and macros used in the code. These files need to be available **in your assembler's include path**.

## Running the Game

To run the game, you will need a TI-83 PCE calculator or a compatible emulator.
Compile the project as described above, and then:

-   For emulators, I recommend [CEmu](https://github.com/CE-Programming/CEmu). Transfer the built executable to your calculator and run it with `Asm(prgmMAIN)`.
-   For real calculators, you will need to use [TI-Connect CE](https://education.ti.com/en/products/computer-software/ti-connect-ce-sw) to transfer the executable to your calculator.

> [!NOTE]\
> The `Asm(` command could be found with `2nd` + `0`, and scrolling.
> You could also use the `prgm` button to select the program.

<!-- ## Future Work

The current version of the game is very basic and there are many features still to be implemented, including:

-   Game logic: The game currently does not have any gameplay logic. This will be added in future versions.
-   Rendering: The game needs a rendering engine to display the game world on the calculator's LCD display.
-   Input handling: The current input handling is very basic and needs to be expanded to handle game controls. -->
