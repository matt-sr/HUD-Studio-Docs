Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## ID

### Melee ID
`equipment.melee_id` · `string` · `string | nil` · id from `weapon_melee`

Melee weapon template ID

e.g. powermaul_shield_p1_m2

### Melee Weapon Name
`equipment.melee_name` · `string` · `string | nil`

Melee weapon display name

### Ranged ID
`equipment.ranged_id` · `string` · `string | nil` · id from `weapon_ranged`

Ranged weapon template ID

e.g. autogun_p1_m1

### Ranged Weapon Name
`equipment.ranged_name` · `string` · `string | nil`

Ranged weapon display name

e.g. Agripinaa Mk VIII Braced Autogun

## Currently Equipped

### Melee In Hand?
`equipment.melee_is_equipped` · `boolean` · `true | false`

Is melee weapon in hand?

### Ranged In Hand?
`equipment.ranged_is_equipped` · `boolean` · `true | false`

Is ranged weapon in hand?

## Charge

### Charge-Up Full At [%]
`equipment.charge_max_percent` · `number` · `0.0 .. n`

% charge counted as fully charged

Usually 100; 100 for teammates and when nothing is charging

### Charge-Up [%]
`equipment.charge_percent` · `number` · `0 .. 100`

% charge of held action

0 when nothing is charging

### Charging Up?
`equipment.charge_is_active` · `boolean` · `true | false`

Is an action charging up?

### Fully Charged?
`equipment.charge_is_full` · `boolean` · `true | false`

Has the charge-up reached full?

## Melee Special / Alt

### Charges
`equipment.melee_special_charges` · `integer` · `0 .. n`

Available melee special charges

### Charges Max
`equipment.melee_special_charges_max` · `integer` · `0 .. n`

Max melee special charges

### Full Recharge Progress [%]
`equipment.progress_percent_to_melee_special_charges` · `number` · `0 .. 100`

% progress to max melee special charges

Includes the charge in flight; 100 when full

### Has Special/Alt Mode?
`equipment.melee_has_alternate_or_special_mode` · `boolean` · `true | false`

Does melee weapon have alternate mode or special?

### Has Thresholds?
`equipment.melee_special_has_thresholds` · `boolean` · `true | false`

Can melee special cross thresholds?

### Next Charge Progress [%]
`equipment.progress_percent_to_melee_special_charge` · `number` · `0 .. 100`

% progress to next melee special charge

100 when full; 0 with no timer

### Seconds til Charge
`equipment.melee_special_charge_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds until next melee special charge

0 when full; 0 with no timer (kill/hit-fed charges, teammates' cooldown weapons)

### Special/Alt Mode Active?
`equipment.melee_special_active` · `boolean` · `true | false`

Is melee weapon special active?

### Thresholds Current
`equipment.melee_special_thresholds_current` · `integer` · `0 .. n`

Last melee special threshold crossed

0 when none crossed

### Thresholds Max
`equipment.melee_special_thresholds_max` · `integer` · `0 .. n`

Thresholds the melee special can cross

### Uses Charges?
`equipment.melee_uses_special_charges` · `boolean` · `true | false`

Does melee weapon use special charges?

## Ranged Special / Alt

### Charges
`equipment.ranged_special_charges` · `integer` · `0 .. n`

Available ranged special charges

### Charges Max
`equipment.ranged_special_charges_max` · `integer` · `0 .. n`

Max ranged special charges

### Full Recharge Progress [%]
`equipment.progress_percent_to_ranged_special_charges` · `number` · `0 .. 100`

% progress to max ranged special charges

Includes the charge in flight; 100 when full

### Has Special/Alt Mode?
`equipment.ranged_has_alternate_or_special_mode` · `boolean` · `true | false`

Does ranged weapon have alternate mode or special?

### Has Thresholds?
`equipment.ranged_special_has_thresholds` · `boolean` · `true | false`

Can ranged special cross thresholds?

### Next Charge Progress [%]
`equipment.progress_percent_to_ranged_special_charge` · `number` · `0 .. 100`

% progress to next ranged special charge

100 when full; 0 with no timer

### Seconds til Charge
`equipment.ranged_special_charge_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds until next ranged special charge

0 when full; 0 with no timer (kill/hit-fed charges, teammates' cooldown weapons)

### Special/Alt Mode Active?
`equipment.ranged_special_active` · `boolean` · `true | false`

Is ranged weapon special active?

### Thresholds Current
`equipment.ranged_special_thresholds_current` · `integer` · `0 .. n`

Last ranged special threshold crossed

0 when none crossed

### Thresholds Max
`equipment.ranged_special_thresholds_max` · `integer` · `0 .. n`

Thresholds the ranged special can cross

### Uses Charges?
`equipment.ranged_uses_special_charges` · `boolean` · `true | false`

Does ranged weapon use special charges?

## Overheat

### Melee In Overheat Lockout?
`equipment.melee_overheat_lockout` · `boolean` · `true | false`

Is melee weapon in overheat lockout?

### Melee Overheat [%]
`equipment.melee_overheat_percent` · `number` · `0 .. 100`

% melee weapon overheat

### Melee Overheats?
`equipment.melee_overheats` · `boolean` · `true | false`

Can melee weapon overheat?

### Ranged In Overheat Lockout?
`equipment.ranged_overheat_lockout` · `boolean` · `true | false`

Is ranged weapon in overheat lockout?

### Ranged Overheat [%]
`equipment.ranged_overheat_percent` · `number` · `0 .. 100`

% ranged weapon overheat

### Ranged Overheat?
`equipment.ranged_overheats` · `boolean` · `true | false`

Can ranged weapon overheat?

## Icons

### Ammo Icon (Shiv Ammo)
`equipment.ammo_icon` · `material` · `string | nil`

Weapon's ammo counter icon

Only shivs set one; nil for every other weapon

### Icon
`equipment.icon` · `material` · `string | nil`

Weapon icon

Wielded: the weapon in hand, or the last one held while holding anything else

```lua
local weapon_options = {
    "wielded",
    "melee",
    "ranged"
}

with_options(sources.player_1.equipment, "icon", {
    weapon = weapon_options[1]
})
```

## Reserve Ammo

### Ammo Color
`equipment.ammo_color` · `argb` · `{ a, r, g, b }`

Vanilla team panel's ammo icon tint

By total rounds left; grey when the weapon uses no ammo; nil with no weapon

### Ammo Reserve
`equipment.ammo_reserve` · `integer` · `0 .. n`

Rounds left in reserve

### Ammo Reserve Max
`equipment.ammo_reserve_max` · `integer` · `0 .. n`

Max rounds in reserve

### Ammo Reserve [%]
`equipment.ammo_reserve_percent` · `number` · `0 .. 100`

% of reserve rounds left

### Ranged Uses Ammo?
`equipment.ranged_uses_ammo` · `boolean` · `true | false`

Does ranged weapon use ammo?

### Reserve Magazines
`equipment.ammo_reserve_mags` · `number` · `0.0 .. n`

Reserve magazines left, as a fraction

### Total Rounds Remaining
`equipment.ammo_rounds_remaining` · `integer` · `0 .. n`

Total rounds left

Magazine + reserve

### Total Rounds Remaining [%]
`equipment.ammo_rounds_remaining_percent` · `number` · `0 .. 100`

% of total rounds left

## Magazine

### Magazine Max
`equipment.ammo_mag_max` · `integer` · `0 .. n`

Max rounds in magazine

### Magazine Remaining
`equipment.ammo_mag_remaining` · `integer` · `0 .. n`

Rounds left in magazine

### Magazine Remaining [%]
`equipment.ammo_mag_remaining_percent` · `number` · `0 .. 100`

% of magazine rounds left

### Magazines Capacity
`equipment.ammo_mags_capacity` · `integer` · `0 .. n`

Max full magazines carried

### Magazines Remaining
`equipment.ammo_mags_remaining` · `number` · `0.0 .. n`

Total magazines left, as a fraction

Current magazine included

### Magazines Remaining [%]
`equipment.ammo_mags_remaining_percent` · `number` · `0 .. 100`

% of total magazine capacity left

### Partial + Reserve Magazines
`equipment.ammo_reserve_mag_remaining` · `number` · `0.0 .. n`

Magazines left, stepping on reload

As ammo_mags_remaining, but steps on a reload, not with every shot

### Partial + Reserve Magazines [%]
`equipment.ammo_reserve_mag_remaining_percent` · `number` · `0 .. 100`

% of magazines left, stepping on reload

As ammo_mags_remaining_percent, but steps on a reload, not with every shot

## Reload

### Reload Progress [%] (Animation)
`equipment.progress_percent_to_reload_animation_finish` · `number` · `0 .. 100`

% progress through reload animation

0 when not reloading

### Reload Progress [%] (Mag Fill)
`equipment.progress_percent_to_reload_finish` · `number` · `0 .. 100`

% progress to ammo in magazine

0 when not reloading

### Reload Secs. Remaining (Animation)
`equipment.reload_animation_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds left on reload animation

0 when not reloading

### Reload Secs. Remaining (Mag Fill)
`equipment.reload_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds until ammo is in magazine

0 when not reloading

### Reload Total Seconds (Animation)
`equipment.reload_animation_total_time` · `number` · `0.0 .. n`

Total seconds of reload animation

Answers while idle too; 0 when the weapon can't reload

### Reload Total Seconds (Mag Fill)
`equipment.reload_total_time` · `number` · `0.0 .. n`

Total seconds until ammo is in magazine

From reload start; answers while idle too; 0 when the weapon can't reload

### Reloading?
`equipment.is_reloading` · `boolean` · `true | false`

Is wielded weapon reloading?

## Misc.

### Reload Progress [%] (Full Mag - for shotguns etc)
`equipment.progress_percent_to_full_reload` · `number` · `0 .. 100`

% progress to full magazine

Across a whole reload, shotgun shells included; 0 when not reloading
