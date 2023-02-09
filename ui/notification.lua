conky.config = {
	update_interval = 2, -- update interval in seconds
	xinerama_head = 0, -- for multi monitor setups, select monitor to run on: 0,1,2
	double_buffer = true, -- use double buffering (reduces flicker, may not work for eveoryone)

	-- window alignment
	alignment = "top_right", -- top|middle|bottom_left|right
	gap_x = 20, -- same as passing -x at command line
	gap_y = tonumber(os.getenv("Y_GAP")),

	-- window settings
	minimum_width = 300,
	minimum_height = 20,
	max_text_width = 80,
	own_window = true,
	own_window_type = "normal", -- values: desktop (background), panel (bar)
	own_window_hints = "undecorated,above,sticky,skip_taskbar,skip_pager",

	-- transparency configuration
	draw_blended = false,
	own_window_transparent = true,
	own_window_argb_visual = true, -- turn on transparency
	own_window_argb_value = 255, -- range from 0 (transparent) to 255 (opaque)

	-- window borders
	draw_borders = true, -- draw borders around the conky window
	border_width = 0, -- width of border window in pixels
	stippled_borders = 0, -- border stippling (dashing) in pixels
	border_inner_margin = 10, -- margin between the border and text in pixels
	border_outer_margin = 0, -- margin between the border and the edge of the window in pixels

	-- graph settings
	draw_graph_borders = false, -- borders around the graph, ex. cpu graph, network down speed grah
	-- does not include bars, ie. wifi strength bar, cpu bar

	imlib_cache_flush_interval = 300,
	-- use the parameter -n on ${image ..} to never cache and always update the image upon a change

	-- font settings
	draw_shades = false, -- black shadow on text (not good if text is black)

	-- colors
	use_xft = true,
	background = true,
	own_window_colour = "212121", -- background
	default_color = "C5C8C6", -- regular text
	color1 = "C5C8C6", -- text labels
	color2 = "212121", -- bar
	color3 = "212121", -- bar critical
}

conky.text = [[
${font JetBrainsMono NF:bold:size=12}${exec echo $heading}
${font JetBrainsMono NF:size=10}${exec echo $message}
${voffset 10}${alignr}${font JetBrainsMono NF:size=8}${exec echo $program}
]]

-- ${color 729FCF}${font OpenLogos:size=12}B $font${color} dudko-arch ${color ffffff}$kernel${color}  |  ${color}Cpu1: ${color ffffff}${cpu cpu1}% / ${color ffffff}${execi 300 sensors | grep Core\ 0 | cut -c15-16 ;}°C${color}  Cpu2: ${color ffffff}${cpu cpu2}% / ${execi 300 sensors | grep Core\ 1 | cut -c15-16 ;}°C${color}  ${color}Gpu: ${color ffffff}${execi 60 nvidia-settings -query GPUCoreTemp | perl -ne 'print $1 if /GPUCoreTemp.*?: (\d+)./;'}°C  ${color}Ram: ${color ffffff}${memperc}%${color}  |  ${color}Root: ${color ffffff}${fs_free /}${color}  Home: ${color ffffff}${fs_free /home}${color}  |  ${if_existing /proc/net/route wlan0}Up: ${color ffffff}${upspeedf wlan0} kb/s${color}  Down: ${color ffffff}${downspeedf wlan0} kb/s${color}${else}${if_existing /proc/net/route eth0}Up: ${color ffffff}${upspeedf eth0} kb/s${color}  Down: ${color ffffff}${downspeedf eth0} kb/s${color}${else}Network Unavailable${endif}  |
