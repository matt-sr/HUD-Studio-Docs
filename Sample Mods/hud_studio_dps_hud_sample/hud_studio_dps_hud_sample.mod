return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`hud_studio_dps_hud_sample` encountered an error loading the Darktide Mod Framework.")

		new_mod("hud_studio_dps_hud_sample", {
			mod_script       = "hud_studio_dps_hud_sample/scripts/mods/hud_studio_dps_hud_sample/hud_studio_dps_hud_sample",
			mod_data         = "hud_studio_dps_hud_sample/scripts/mods/hud_studio_dps_hud_sample/hud_studio_dps_hud_sample_data",
			mod_localization = "hud_studio_dps_hud_sample/scripts/mods/hud_studio_dps_hud_sample/hud_studio_dps_hud_sample_localization",
		})
	end,
	packages = {},
}
