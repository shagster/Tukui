local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

C["general"] = {
	["autoscale"] = false,                              -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = .7111111,                                 -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,                      -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = false,                     -- i don't recommend this because of shitty border but, voila!
	["backdropcolor"] = { .05, .05, .05},            	-- default backdrop color of panels
	["bordercolor"] = { .125, .125, .125, 1},           -- default border color of panels
	["skinblizz"] = true,				   			    -- skin blizzard frames (other)
}

C["unitframes"] = {

	-- layout
	["style"] = "Shag",                                 -- unitframe style, choose from ("Shag") or ("Smelly")

	-- general options
	["enable"] = true,                                  -- do i really need to explain this?
	["enemyhcolor"] = false,                            -- enemy target (players) color by hostility, very useful for healer.
	["unitcastbar"] = true,                             -- enable the tukui castbar
	["bigfocuscast"] = false,							-- Enable larger than life focus castbar in middle of screen?
	["showfocustarcast"] = false,						-- Show the focus target's castbar?
	["petcastbar"] = false,				    			-- Pet castbar
	["cblatency"] = false,                              -- enable castbar latency
	["cbicons"] = true,                                 -- enable icons on castbar
	["auratimer"] = true,                               -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                             -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = false,                            -- enable Player auras
	["targetauras"] = false,                            -- enable Target auras
	["lowThreshold"] = 20,                              -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = false,                     -- enable power text on pvp target only
	["totdebuffs"] = false,                             -- enable tot debuffs (high reso only)
	["showtotalhpmp"] = false,                          -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                              -- enable smooth bar
	["charportrait"] = false,                           -- little baby portraits
	["classicon"] = false,								-- option to enable class icon on player/target
	["showfocustarget"] = true,							-- Do you want to see the focus' target?
	["showpettarget"] = true,							-- Do you want to see zee pet's target?
	["maintank"] = false,                               -- enable maintank
	["mainassist"] = false,                             -- enable mainassist
	["unicolor"] = true,                                -- enable unicolor theme
	["unicolorgradient"] = false,			    		-- enable gradient on unicolor player/target frames
	["combatfeedback"] = false,                         -- enable combattext on player and target.
	["playeraggro"] = false,                            -- color player border to red if you have aggro on current target.
	["healcomm"] = false,                               -- enable healprediction support.
	["onlyselfdebuffs"] = true,                         -- display only our own debuffs applied on target
	["bordercolor"] = {  0, 0, 0, 1  },                 -- unit frames panel border color
	["extendedpet"] = true,                             -- extended pet frame (only for Shag layout style)
	["showsolo"] = false,                        	    -- show raid frames when solo (DPS only)
		
	-- raid layout (if one of them is enabled)
	["showrange"] = true,                               -- show range opacity on raidframes
	["raidalphaoor"] = 0.2,                             -- alpha of unitframes when unit is out of range
	["gridonly"] = true,                                -- enable grid only mode for all healer mode raid layout.
	["showsymbols"] = true,	                            -- show symbol.
	["aggro"] = false,                                  -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,                     -- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,                      -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,                       -- show my player frame in party
	["gridscale"] = 1,                                  -- set the healing grid scaling
	["gradienthealth"] = true,                          -- change raid health color based on health percent.
		["gradient"] = {                            	-- health gradient color if unicolor is true.
			1.0, 0.3, 0.3, -- R, G, B (low HP)
			0.6, 0.3, 0.3, -- R, G, B (medium HP)
			0.165, 0.165, 0.165, -- R, G, B (high HP)  .3 .3 .3
	},
	-- boss frames
	["showboss"] = true,                                -- enable boss unit frames for PVELOL encounters.

	-- priest only plugin
	["weakenedsoulbar"] = false,                        -- show weakened soul bar
	
	-- class bar
	["classbar"] = true,				    			-- enable tukui classbar over player unit. Must be enabled if you want any individual classbars enabled.
		["druid"] = false,								-- enable druid only classbar
		["deathknight"] = true,							-- enable deathknight only classbar
		["shaman"] = true,								-- enable shaman only classbar
}

C["arena"] = {
	["unitframes"] = true,                              -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
}

C["auras"] = {
	["player"] = true,                                  -- enable tukui buffs/debuffs by minimap
}

C["actionbar"] = {
	["enable"] = true,                                  -- enable tukui action bars
	["hotkey"] = true,                                	-- enable hotkey display because it was a lot requested
	["hideshapeshift"] = false,                         -- hide shapeshift or totembar because it was a lot requested.
	["verticalshapeshift"] = false,						-- set shapeshift bar to show vertically
	["showgrid"] = true,                                -- show grid on empty button
	["buttonsize"] = 27,                                -- normal buttons size
	["petbuttonsize"] = 26,                             -- pet & stance buttons size
	["buttonspacing"] = 3,                              -- buttons spacing
	["mainbarWidth"] = 7,				    			-- amount of buttons per row on main bar (set between 1-12)
	["sidebarWidth"] = 6,				    			-- amount of buttons per row on side bars (set between 0-6, 0 = disabled)
	["bgPanel"] = true,				    				-- enable background panels for actionbars
}

C["castbar"] = { 
	["classcolor"] = false, 							-- classcolor
	["castbarcolor"] = { 1, 1, 0, 1 }, 					-- color if classcolor = false
	["nointerruptcolor"] = { 1, 0, 0, 1 }, 				-- color of casts which can't be interrupted
}

C["Addon_Skins"] = {
	["background"] = false,				    			-- Create a Panel that has the exactly same size as the left chat, placed at the bottomright (for addon placement)
	["combat_toggle"] = false,			    			-- Shows the Addon Background, Omen, Recount & Skada infight, hides outfight
	["Recount"] = false,				    			-- Enable Recount Skin
	["Skada"] = false,			            			-- Enable Skada Skin
	["Omen"] = false,				    				-- Enable Omen Skin
	["KLE"] = false,				    				-- Enable KLE Skin
	["DBM"] = true,										-- Enable DBM Skin. Must run "/dbmskin apply" per character in game
	["TinyDPS"] = true,				    				-- Enable TinyDPS Skin
	["Auctionator"] = false,							-- Enable Auctionator Skin
	["Bigwigs"] = true,									-- Enable Bigiwgs Skin
}

C["sCombo"] = {
	["enable"] = true,				    				-- Enable sCombo-Addon for combopoints instead of default cp-display
	["energybar"] = true,				    			-- show energy-Bar below cp bar
}


C["bags"] = {
	["enable"] = true,                                  -- enable an all in one bag mod that fit tukui perfectly
}

C["map"] = {
	["enable"] = true,                                  -- reskin the map to fit tukui
	["location_panel"] = true,							-- show location panel at top of the screen
}

C["loot"] = {
	["lootframe"] = true,                               -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,                           -- reskin the roll frame to fit tukui
	["autogreed"] = false,                              -- auto-dez or auto-greed item at max level, auto-greed Frozen orb
}

C["cooldown"] = {
	["enable"] = true,                                  -- do i really need to explain this?
	["treshold"] = 5,                                   -- show decimal under X seconds and text turn red
}

C["extra_panels"] = {
	["toppanel"] = false, 				    			-- enable or disable top blank panel.
	["bottompanel"] = false, 			    			-- enable or disable bottom blank panel.
	["threatbar"] = true,								-- shows threatbar attached to Tuk left chat panel
		
	}

C["datatext"] = {
	["fps_ms"] = 4,                                     -- show fps and ms on panels
	["system"] = 5,                                     -- show total memory and others systems infos on panels
	["bags"] = 0,                                       -- show space used in bags on panels
	["gold"] = 0,                                       -- show your current gold on panels
	["wowtime"] = 7,                                    -- show time on panels
	["guild"] = 2,                                      -- show number on guildmate connected on panels
	["dur"] = 6,                                        -- show your equipment durability on panels.
	["friends"] = 3,                                    -- show number of friends connected.
	["dps_text"] = 0,                                   -- show a dps meter on panels
	["hps_text"] = 0,                                   -- show a heal meter on panels
	["power"] = 0,                                      -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 0,                                      -- show your haste rating on panels.
	["crit"] = 0,                                       -- show your crit rating on panels.
	["avd"] = 0,                                        -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                                      -- show your armor value against the level mob you are currently targeting
	["currency"] = 0,                                   -- show your tracked currency on panels
	["hit"] = 0,                                        -- show hit rating
	["mastery"] = 0,                                    -- show mastery rating
	["micromenu"] = 0,                                  -- add a micro menu thought datatext
	["regen"] = 0,					    				-- show mana regeneration
	["specswitcher"] = 1,				    			-- show current spec and allows mouse-click spec change. Set to position 1 for best results.
		
	-- Color Datatext
	["classcolored"] = false,			    			-- classcolored datatext
	["color"] = {0, 1, 0},					    		-- datatext color (if classcolored = false)
	-- Color Panel Text
	["classpanel"] = false,								-- set the extra panels to class colored
	["statcolor"] = {0, 1, 0},							-- color of extra panels if classpanel is False
	
	["battleground"] = true,                            -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = false,                                 -- set time to 24h format.
	["localtime"] = true,                               -- set time to local time instead of server time.
	["fontsize"] = 10,                                  -- font size for panels.
}


C["chat"] = {
	["enable"] = true,                                  -- blah
	["whispersound"] = true,                            -- play a sound when receiving whisper
	["background"] = true,								-- Dont make it false!!!
	["layout_switch"] = false,							-- Enable the layout switcher button thing on right chat tab
}


C["nameplate"] = {
	["enable"] = true,                                  -- enable nice skinned nameplates that fit into tukui
	["showhealth"] = false,				    			-- show health text on nameplate
	["enhancethreat"] = false,			    			-- threat features based on if your a tank or not
	["combat"] = false,			            			-- only show enemy nameplates in-combat.
	["goodcolor"] = {75/255,  175/255, 76/255},	    	-- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},	 	    		-- bad threat color (opposite of above)
	["transitioncolor"] = {218/255, 197/255, 92/255},   -- threat color when gaining threat
}


C["tooltip"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	["hidecombat"] = false,                             -- hide bottom-right tooltip when in combat
	["hidebuttons"] = true,                             -- always hide action bar buttons tooltip.
	["hideuf"] = false,                                 -- hide tooltip on unitframes
	["cursor"] = true,                                  -- tooltip via cursor only
}

C["merchant"] = {
	["sellgrays"] = true,                               -- automaticly sell grays?
	["autorepair"] = false,                             -- automaticly repair?
	["guildrepair"] = true,								-- automatically use guild funds to repair (if available)
	["sellmisc"] = false,                               -- sell defined items automatically
}

C["error"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	filter = {                                          -- what messages to not hide
		[INVENTORY_FULL] = true,                    	-- inventory is full will not be hidden by default
	},
}

C["invite"] = { 
	["autoaccept"] = true,                              -- auto-accept invite from guildmate and friends.
}

C["buffreminder"] = {
	["enable"] = true,                                  -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = false,                                  -- enable warning sound notification for reminder.
	["raidbuffreminder"] = true,			    		-- enable panel with missing raid buffs below the minimap
}
