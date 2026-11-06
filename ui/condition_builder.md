The Condition Builder turns a list of rules into one true / false answer. It opens from any field in `Conditions` mode.

`Conditions` is the default for `Visible`. Threshold inputs, Events and variable Cases use it too.

## A row

Each row is one rule:

| Part     | Does                                                  |
| -------- | ----------------------------------------------------- |
| Pill     | lit while the row is true                             |
| Left     | the value to test                                     |
| Is       | click to flip to `Is Not`                             |
| Operator | how to compare                                        |
| Right    | the value to compare against. Only for some operators |
| x        | removes the row                                       |

A row reads as a sentence: _health is below 30_.

Up to 16 rows. There is no Add button. The blank row at the bottom becomes a new row once you fill it in.

## Operands

Click an operand to open it. It takes the same modes as a field:

| Mode                  | Value                                  |
| --------------------- | -------------------------------------- |
| `Static`              | a typed value: a number, text or an id |
| `Data Source`         | a live game value                      |
| `Signals`, `Controls` | a pulse, or a key / action held        |
| `Variable`            | one of the block's variables           |
| `Code`                | a script's answer                      |

A `Static` box has a dropdown of matching ids, so you rarely type them.

The check beside the mode closes the operand again. A closed operand shows how it resolves: `P1  Status  Health %`.

## Operators

| Operator    | True while the left value is       | Right values |
| ----------- | ---------------------------------- | ------------ |
| `true`      | true, or any non-zero value        | 0            |
| `false`     | false, nil or 0                    | 0            |
| `equal to`  | the right value                    | 1            |
| `pattern`   | text that contains the pattern     | 1            |
| `below`     | less than                          | 1            |
| `at most`   | less than or equal                 | 1            |
| `above`     | greater than                       | 1            |
| `at least`  | greater than or equal              | 1            |
| `between`   | inside both values, edges included | 2            |
| `changed`   | different from the last update     | 0            |
| `increased` | higher than the last update        | 0            |
| `decreased` | lower than the last update         | 0            |

The list depends on the left value's type. A true / false value only gets `true`, `false` and `changed`. A colour gets none.

`changed`, `increased` and `decreased` are true for one update. Add a Linger to keep something up.

`pattern` takes a Lua pattern, not a regex: `%d`, not `\d`. Split options with `|`: `plasma|lasgun`.

For "not equal", use `equal to` and flip `Is` to `Is Not`.

## And / Or

The word between two rows joins them. Click it to switch between `and` and `or`.

`and` binds tighter than `or`:

- `A and B or C` reads as `(A and B) or C`.
- `A or B and C` reads as `A or (B and C)`.

An empty list is always true.

## Unless

Below the main rows sits a second blank row: _Unless_. Rows added there are the exception.

The list is true while the main rows are true **and** the exception is not.

`A or B or C` unless `D` shows for any of A, B, C, but never while D holds.

One Unless group per list. With no main rows, it reads as "always, unless".

## Live pills

While the builder is open, each row's pill shows its truth right now.

| Pill  | Means                                         |
| ----- | --------------------------------------------- |
| Green | true                                          |
| Grey  | false                                         |
| Dark  | unknown: the block is not checking this frame |

The pills show the rules alone. Something else can still hide the block. The info line at the bottom says what:

- the eye, its own or its group's
- a `Gamemodes` or `Classes` filter
- a Quick Condition
- a missing required mod
- a forced-on eye, which ignores the rules

## Reorder

Drag a row by its handle. A row stays on its side of the Unless line.

## Copy and paste

| Button         | Does                                    |
| -------------- | --------------------------------------- |
| `Copy`         | copies every row                        |
| `Paste`        | replaces every row with the copied ones |
| `Copy as Code` | copies the rules as a Lua script        |

Right-click a row to copy or paste that row alone.

To move a list to scripting, use `Copy as Code`, switch the field to `Code` mode and paste it in the Code Editor.

## Linger and Delay

A nested rule list, such as a colour threshold's input, has _Linger for_ and _Delay for_ at the bottom. They time that list only.

A block's or node's `Visible` uses the _Timing_ card instead. Events have their own. See [Linger & Delay](../scripting/linger_delay.md).

## Good to know

- Put the cheapest, most often false row first in an `and` run. The rest are skipped while it is false.
- `changed`, `increased` and `decreased` rows always run, so they never miss an update.
- Each operand has a Code Editor button. A bad script shows its error on that operand.
