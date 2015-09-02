extends Sprite

var dir = Vector2(0,0)
var speed = 200
var damage = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if damage != 0:
		self.translate( dir * speed * delta )
	else:
		queue_free()

func _on_BulletColli_body_enter( body ):	
	if body.get_name() == "TileMap":
		var pos = body.world_to_map(get_pos())
		var id = body.get_cell(pos.x,pos.y)
		var body_name = body.get_tileset().tile_get_name(id)
		# body_object = 
	#body is name and not a object!
	if body.get_name().begins_with("WallColli"):
		damage = 0
	elif body.get_name().begins_with("BrickColli"):
		body.get_parent().hit(damage)
		damage = 0
	elif body.get_name().begins_with("PlayerColli"):
		body.hit(damage)
		damage = 0
func hit_me(body):
	body.hit(damage)
	damage = 0
