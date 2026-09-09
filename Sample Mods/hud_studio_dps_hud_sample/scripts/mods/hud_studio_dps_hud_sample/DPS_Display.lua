return {
	export_mod = "hud_studio_dps_hud_sample",
	grid_cols = 0,
	grid_rows = 0,
	label = "DPS Display",
	localizations = {},
	name = "DPS_Display",
	nodes = {
		{
			id = "rect_2",
			label = "Background",
			offset = {
				911,
				39,
			},
			style = {
				color = {
					255,
					255,
					255,
					255,
				},
				size = {
					264,
					107,
				},
			},
			type = "rect",
			values = {
				material = "content/ui/materials/buttons/mb_play_button_selected",
			},
		},
		{
			callbacks = {
				value = {
					color = {
						body = "\
if block.state.dps_color ~= nil then\
\
  -- Note from earlier where we wrote the block's script to store a `dps_color` reference to 'state.dps_color'\
\
  color = block.state.dps_color()\
\
else\
  -- Define a fallback value, in case block.state.dps_color does not exist\
  -- if you want the text color to use the 'static' mode value - set color to nil.\
  color = { 255, 185, 235, 179 } -- mint green\
end\
",
						kind = "code",
					},
					text = {
						body = "\
if block.state.dps_display ~= nil then\
\
  -- Note from earlier where we wrote the block's script to store a `dps_display` reference to 'state.dps_display'\
\
  text = block.state.dps_display() .. \"dps\"\
\
else\
  -- Define a fallback value, in case block.state.dps_display does not exist.\
  -- Note that setting text to nil does NOT hide it - a nil result falls back to the\
  -- static value you authored on the node. To hide it, use the node's Visible field.\
  text = 0 .. \"dps\"\
end\
",
						kind = "code",
					},
				},
			},
			id = "text_1",
			label = "DPS Display",
			offset = {
				911,
				83,
			},
			style = {
				align = "center",
				color = {
					255,
					214,
					231,
					207,
				},
				font_size = 26,
				font_type = "mono_tide_bold",
				shadow = true,
				size = {
					264,
					30,
				},
			},
			type = "text",
			values = {
				mode = "fixed",
			},
		},
	},
	offset = {
		-1050,
		-479,
	},
	requires = {
		"hud_studio_dps_hud_sample",
	},
	script = {
		body = "\
-- If the state does not hold a reference to your mod yet, do that first\
\
if not state.mod then\
  state.mod = get_mod(\"hud_studio_dps_hud_sample\")\
end\
\
-- If for some reason get_mod did not get your mod handle, exit early to avoid errors.\
-- This will run again on the next frame, so it will get the mod eventually (unless you typo'd)\
\
if not state.mod then\
  return\
end\
\
-- Here we can store references to your mod's functions, which the nodes in this block can access.\
-- You don't need to do this (can just access these via state.mod), but it will be more convenient and less verbose.)\
\
state.dps_display = state.mod.dps_display\
state.dps_color = state.mod.dps_color",
	},
	summary = "My cool DPS display!",
	tags = {
		"tag",
		"tag2",
		"tag3",
	},
	version = 1,
	visible = {
		conditions = {
			rows = {},
		},
		kind = "conditions",
	},
}