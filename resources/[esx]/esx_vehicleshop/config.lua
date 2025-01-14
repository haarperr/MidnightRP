Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'en'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = { x = -33.65, y = -1103.02, z = 25.42 }, 
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	ShopInside = {
		Pos     = { x = -45.28, y = -1097.77, z = 25.42 }, 
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 246,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = -45.28, y = -1097.77, z = 25.42 }, 
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 246,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = -1176.71, y = -1700.29, z = 4.78 }, 
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = { x = -198.11, y = -1297.54, z = 31.3}, 
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	ResellVehicle = {
		Pos   = { x = -48.71, y = -1081.63, z = 25.81 }, 
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}

}
