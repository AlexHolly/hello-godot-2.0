
extends TileMap

var tilemap = load("res://scripts/tilemap.gd")

onready var map = get_parent().get_node("Map")

var objects = {
	"Brick":"res://scenes/brick.scn",
	"Wall":"res://scenes/wall.scn"

}

func _ready():
	tilemap.build_tilemap(self, objects, map)