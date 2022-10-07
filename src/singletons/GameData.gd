extends Node


var tower_data = {
	"Ballistae1": {
		"damage": 1,
		"rof": 1,
		"range": 500,
		"cost": 2,
		"ammo": "Arrow"
		},
	"Catapult1": {
		"damage": 2,
		"rof": 2,
		"range": 800,
		"cost": 5,
		"ammo": "Fireball"
	},
		"IceTower1": {
		"damage": 1,
		"rof": 2.5,
		"range": 400,
		"cost": 3,
		"ammo": "IceShard"
	}
}

var hp: int = 5
var gold: int = 5
var current_level: int = 1
