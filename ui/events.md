An event runs actions when something changes. Events live on a block, in its `Events` tab.

Every sound action needs the **SimpleAudio** mod. Without it, nothing plays.

Events don't run while the editor is open. Use the play button on an action to test it.

## Adding an event

Click **+ Add Event**. A block holds up to 8 events.

Each event is a card. Click its bar to open or fold it.

The toggle on the bar switches the event on or off without deleting it.

## The trigger

The first line of a card is `When...`. Pick a mode, set it up, then pick an edge.

| Mode          | Fires on                         |
| ------------- | -------------------------------- |
| `Conditions`  | rules from the Condition Builder |
| `Data Source` | a game value                     |
| `Controls`    | a key press or game action       |
| `Signals`     | a moment, e.g. a kill or a hit   |
| `Code`        | a Lua script                     |
| `Game Sound`  | a sound the game plays           |

### Edges

The edge says which change fires the event.

| Edge            | Fires                              |
| --------------- | ---------------------------------- |
| `Becomes True`  | once, when the trigger turns true  |
| `Becomes False` | once, when the trigger turns false |
| `Changes`       | once, on every change              |
| `Is True`       | for as long as the trigger is true |

- Numbers and text can only fire on `Changes`.
- Signals are instant. They fire once, never held.

### Timing

| Option             | Does                                               |
| ------------------ | -------------------------------------------------- |
| `...and holds for` | seconds the trigger must stay true before it fires |
| `Linger`           | seconds to keep going after the trigger drops      |
| `Cooldown`         | seconds before it can fire again. 0 is no limit    |
| Visible toggle     | `Only when visible` or `Even when hidden`          |

- `Linger` only works with `Is True`.
- `Cooldown` doesn't work with `Is True`.
- Gamemode and Class filters stop an event even when set to `Even when hidden`.

## Game Sound triggers

A `Game Sound` trigger fires when the game plays a matching sound.

1. Turn on **WWISE LOGGER**. It lists the last 20 sounds the game played.
2. Click a sound to copy its name.
3. Paste it into the trigger.

Pick how the name is matched: `Is`, `Starts With`, `Ends With`, `Contains` or `Pattern`. `Pattern` takes a Lua pattern.

| Option      | Does                                                          |
| ----------- | ------------------------------------------------------------- |
| `Mute`      | silences the game sound. Your actions play instead            |
| `...and...` | only fires while these conditions are true. Applies to `Mute` |
| `...until`  | a sound that ends repeats. Blank uses the sound's own stop    |

## Actions

An event runs up to 4 actions, top to bottom. Click **+ Add Action** to add one.

| Action                   | Does                                       |
| ------------------------ | ------------------------------------------ |
| `Play Audio File`        | plays a file from a mod's audio folder     |
| `Play Random Audio File` | plays a random file from a folder          |
| `Play Game Sound`        | plays one of the game's own sounds         |
| `Replay Sound`           | plays the heard game sound again           |
| `Silence Game Sound`     | mutes game sounds that match a Lua pattern |

- Put your files in `mods/hud_studio/audio/`. For a mod, put them in that mod's folder.
- `Play Random Audio File` only picks files directly in the folder, not its subfolders.
- `Replay Sound` only shows under a `Game Sound` trigger.
- `Silence Game Sound` under `Is True` is silent while the trigger is true. Under any other edge it is always silent.

### Volume

`Volume %` is a percent of the file's own volume. 100 is unchanged, 200 is double.

Volume can also read a variable.

### Action timing

| Option         | Does                                                     |
| -------------- | -------------------------------------------------------- |
| `Delay`        | seconds before the action runs, counted from the trigger |
| `Repeat Every` | seconds between repeats. 0 runs once                     |
| `Fade Out`     | seconds to fade the sound out when the trigger drops     |

`Repeat Every` needs `Is True`, or a `Game Sound` trigger with a stop sound.

### Loop

Under `Is True`, a file action has a `Loop` option.

| Loop        | Does                                                |
| ----------- | --------------------------------------------------- |
| `Gapless`   | repeats with no gap. Can start or end a loop early  |
| `Retrigger` | starts the sound again each pass. Good for gunshots |
| `Custom`    | repeats on your own timing, set by `Repeat Every`   |
| `Off`       | plays once. Cut off if the trigger drops first      |

## See also

- [Replacing a weapon sound](../tutorials/event_sound.md)
- [Condition Builder](condition_builder.md)
- [Code Editor](code_editor.md)
