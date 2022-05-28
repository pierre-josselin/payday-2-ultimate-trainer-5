# Ultimate Trainer 5

Ultimate Trainer is a cheat for PAYDAY 2 with many features.

Version 5.3.0

<details>
    <summary>Table of contents</summary>
    <ol>
        <li><a href="#getting-started">Getting started</a></li>
        <li><a href="#support">Support</a></li>
        <li><a href="#usage">Usage</a></li>
        <li><a href="#features">Features</a></li>
        <li><a href="#languages">Languages</a></li>
        <li><a href="#credits">Credits</a></li>
    </ol>
</details>

## Getting started

### Prerequisites

If you have not already done so, install [SuperBLT](https://superblt.znix.xyz/).

### Installation

1. Remove any previous version of Ultimate Trainer
2. Download Ultimate Trainer 5
3. Extract the archive to your `PAYDAY 2/mods` folder
4. Start the game

> ⚠️ Please remove any mods or commands that skip the game intro for Ultimate Trainer to initialize properly.

## Support

If you have any problems with the installation or use of Ultimate Trainer 5, or if you want to suggest new features, you can contact us [by creating a post on the Ultimate Trainer 5 UnknownCheats thread](https://www.unknowncheats.me/forum/payday-2-a/491561-payday-2-ultimate-trainer-5-a.html) or [by creating an issue on this GitHub repository](https://github.com/pierre-josselin/payday-2-ultimate-trainer-5/issues/new).

> ℹ️ If your request is about a crash, remember to attach the content of your crash log file (located at `%localappdata%\PAYDAY 2\crash.txt`).

### Questions and answers

**The mod does not work.**

Check the following :

- You have successfully installed SuperBLT (note you must also install **Microsoft Visual C++ 2017 Redistributable package (x86)**).
- You have deleted any previous version of Ultimate Trainer.
- You have placed the ultimate trainer folder (after extracting the archive) in your `PAYDAY 2/mods` directory.
- When you open the ultimate trainer folder, there is directly the `mod.txt` file (so there is no sub-folder).
- You don't use a mod that skip the game intro and you don't use the "-skip_intro" command.

**Can I get banned using this mod ?**

PAYDAY 2 does not have Steam VAC, therefore you cannot be banned by using this mod.

However PAYDAY 2 has a basic anti cheat that detects some features. If you use them, you may be kicked from the lobby or have a CHEATER tag next to your name. This has no consequences and disappears automatically.

**Why do I start heists with only 30% of my health ?**

This is due to the "Frenzy" skill of the "Fugitive" tree :

> Basic (4 pt): You only get 30% of your maximum health and cannot heal above it [...].

[Payday Wiki - Fandom](https://payday.fandom.com/wiki/Frenzy)

## Usage

### Open the menu

Go to `ULTIMATE TRAINER` next to `OPTIONS` (or **F1** if you are in a heist).

### Keybinds

| Key                | Description                          |
|--------------------|--------------------------------------|
| F1                 | Open the menu                        |
| F2                 | Pick the unit (construction mode)    |
| F3                 | Place the unit (construction mode)   |
| F4                 | Remove the unit (construction mode)  |
| MOUSE WHEEL UP     | Select previous unit (spawn mode)    |
| MOUSE WHEEL DOWN   | Select next unit (spawn mode)        |
| MOUSE WHEEL BUTTON | Spawn the selected unit (spawn mode) |
| H                  | Teleport to crosshair                |
| RIGHT ALT          | Replenish health and ammo            |

> You can edit these keys in `OPTIONS / MOD KEYBINDS`.

## Features

### Player menu

Set level, infamy rank, add money, skill points, unlock inventory items, achievements...

### Mission menu

Remove invisible walls, disable the AI, trigger the alarm...

### Dexterity menu

God mode, unlimited ammo, damage multiplier...

### Construction menu

Allows you to copy and paste any unit from the map.

1. Press F2 to pick the unit you are looking
2. Press F3 to place the unit where you are looking
3. Press F4 to remove the unit you are looking

> When you pick a unit, outlines appear. If these outlines are green, the placed units will be seen by the other players. If these outlines are orange, only you will see the placed units.

### Spawn menu

Allows you to spawn any ennemy, ally, civilian, loot, equipment, package or bag.

1. Choose the spawn mode to set
2. Use mouse wheel up and down to select the unit to spawn
3. Click on the mouse wheel button to spawn the unit

### Group spawn menu

Allows you to spawn a group of civilians around you, with various possible animations.

### Time menu

Allows you to choose the time and weather of the heists.

### Driving menu

Allows you to spawn drivable vehicles.

To use this feature, you must first load the packages :

1. Go to `Driving menu`
2. Check the "Enable packages loading" box
3. Restart the heist

### Instant menu

Start, restart, finish or leave the heist.

### Unlocker menu

DLC and skin unlockers.

## Languages

### Supported languages

- English
- French
- Spanish
- Simplified Chinese

### Language selection

1. Go to `OPTIONS / MOD OPTIONS / LANGUAGE`
2. Choose a language among the supported languages
3. Return to the main screen
4. Restart the game

### Contribution

If you want to contribute to the project by adding a language, make a copy of the [english locale](https://github.com/pierre-josselin/payday-2-ultimate-trainer-5/blob/main/locales/en.json).

## How to publish a new version
The release creation flow is automated using github actions.

- The version of `meta.json` and `mod.txt` are generated automatically according to the given tag.

1. Make your adjustments and push to the `main` branch.
2. Create a tag with the new version and push
    ```
    git tag -a <version> -m <realease_message>
    git push origin <version>
    ```
    Example:
    ```
    git tag -a 5.3.0 -m '5.3.0'
    git push origin 5.3.0
    ```

- You can edit/delete the release after creation

## Credits

Most of the features of Ultimate Trainer are developed by me (Pierre Josselin).  
But sometimes I use code created by other developers or other developers contribute directly to this project :

Vinícius Francisco Xavier

- SuperBLT Update
- Invisible Player
- Noclip
- Shoot through walls

ArtemisFowl

- Simplified Chinese locale

Dr_Newbies

- Hide mods list

MS HACK

- Add an item to the start menu

Uziel2021

- Spanish locale
- Help to add Ultimate Trainer to the start menu

rogerxiii

- List of invisible walls keys
- Skill points hack

zReko

- Debug log class
- Change environment without restarting heist
- Units outlines

test1, Tast, Motherflowers, Undeadsewer

- List of packages to load to change environment without crashing

SirGoodSmoke, B1313, Simplity, transcend, PirateCaptain...

If you think Ultimate Trainer is using your work but you are not listed here, please contact me.
