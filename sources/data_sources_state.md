Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## Identity

### Bot?
`state.bot` · boolean · **true | false**

Is slot occupied by a bot?

### You?
`state.local_player` · boolean · **true | false**

Is slot occupied by (You)?

## Vitals

### Alive?
`state.alive` · boolean · **true | false**

Is Player alive?

### Being Revived?
`state.being_revived` · boolean · **true | false**

Is an Ally reviving Player?

Any assist: revive (downed), rescue (hogtied), pull up (ledge), freeing from a net

### Dead?
`state.dead` · boolean · **true | false**

Is Player dead?

### Downed?
`state.downed` · boolean · **true | false**

Is Player knocked down, awaiting a revive?

### Exists?
`state.exists` · boolean · **true | false**

Party slot is occupied?

Hub slots can be empty until the party is full; mission slots always hold a Player or bot; on an empty slot every state leaf reads false, 0 or nil

```lua
if not sources.player_2.state.exists then
	return false
end
return sources.player_2.state.alive
```

### In Play (Alive, Not Hogtied)?
`state.in_play` · boolean · **true | false**

Is Player alive and not hogtied?

A hogtied Player counts as alive but must be rescued

### Is Reviving?
`state.reviving` · boolean · **true | false** · **local player only**

Is Player reviving an Ally?

The other side of `being_revived`; the game only sends this for (You)

### Seconds until rescuable
`state.seconds_until_rescuable` · number · **0.0 .. n**

Seconds until Player is rescuable

Counts down while dead and not in limbo; 0 once rescuable or while in play

```lua
local seconds = sources.player_2.state.seconds_until_rescuable
if seconds > 0 then
	return string.format("Seconds until rescuable: %d", math.ceil(seconds))
end
return "Rescuable"
```

## Danger

### Carrying Luggable?
`state.carrying_luggable` · boolean · **true | false**

Is Player carrying a luggable objective?

e.g. battery, canister, vacuum capsule

### Disabled?
`state.disabled` · boolean · **true | false**

Is Player in any disabled state?

Includes ones that end on their own; `requires_help` for only those needing an Ally

### Hogtied (Awaiting Rescue)?
`state.hogtied` · boolean · **true | false**

Is Player captured, awaiting a rescue?

### Ledge Hanging?
`state.ledge_hanging` · boolean · **true | false**

Is Player hanging from a ledge?

### Mutant Charged?
`state.mutant_charged` · boolean · **true | false**

Is a Mutant disabling Player?

Pinning, slamming or throwing

### Netted?
`state.netted` · boolean · **true | false**

Is a Trapper Net holding Player?

### Pounced?
`state.pounced` · boolean · **true | false**

Is a Hound pinning Player?

### Requires Help?
`state.requires_help` · boolean · **true | false**

Does Player need an Ally to recover?

Subset of `disabled` that never ends alone; what vanilla's assistance marker shows for

### Status Color
`state.status_color` · argb · **{ a, r, g, b }**

Vanilla portrait status icon color

nil when `status_icon` is not applicable

### Status Icon
`state.status_icon` · material · **string | nil**

Vanilla portrait status icon

Picked by priority: dead, hogtied, disabled

### [Beast of Nurgle] Consumed?
`state.consumed` · boolean · **true | false**

Is a Beast of Nurgle disabling Player?

Eating, swallowing or spitting out

### [Chaos Spawn] Grabbed?
`state.grabbed` · boolean · **true | false**

Is a Chaos Spawn disabling Player?

Holding or eating

### [Daemonhost] Grabbed?
`state.warp_grabbed` · boolean · **true | false**

Is a Daemonhost holding Player?

### [Vortex] Grabbed?
`state.vortex_grabbed` · boolean · **true | false**

Is a Sand Vortex disabling Player?

Expeditions only

## Combat

### Aiming? (ADS)
`state.aiming` · boolean · **true | false**

Is Player aiming?

### Attacking?
`state.attacking` · boolean · **true | false**

Is Player mid-attack, melee or ranged?

### Blocking?
`state.blocking` · boolean · **true | false**

Is Player blocking?

### Invisible?
`state.invisible` · boolean · **true | false**

Is Player invisible to enemies?

Works for teammates

## Movement

### Airborne?
`state.airborne` · boolean · **true | false**

Is Player jumping or falling?

### Crouching?
`state.crouching` · boolean · **true | false** · **local player only**

Is Player crouching?

### Dodging?
`state.dodging` · boolean · **true | false**

Is Player mid-dodge?

### Moving?
`state.moving` · boolean · **true | false**

Is Player moving?

### Sliding?
`state.sliding` · boolean · **true | false**

Is Player sliding?

### Sprinting?
`state.sprinting` · boolean · **true | false**

Is Player sprinting?

### Vaulting?
`state.vaulting` · boolean · **true | false**

Is Player vaulting an obstacle?

## Team

### Coherency Count
`state.coherency_count` · number · **0.0 .. n**

Game's own coherency count

Player counts themselves; 1 when alone

### Coherency Count (Excl. self)
`state.coherency_others` · number · **0.0 .. n**

Other Players in coherency with Player

### In Coherency With You?
`state.in_your_coherency` · boolean · **true | false**

Is Player in coherency with (You)?

Always false on your own slot

### In Coherency?
`state.in_coherency` · boolean · **true | false**

Is Player in coherency with anyone?

### In Party?
`state.in_party` · boolean · **true | false**

Is slot occupied and in your party?

### Is Spectated?
`state.spectated` · boolean · **true | false**

Is Player the one you are watching?

### Is Spectating?
`state.spectating` · boolean · **true | false** · **local player only**

Are you spectating?

### Talking?
`state.talking` · boolean · **true | false**

Is Player speaking on voice chat?
