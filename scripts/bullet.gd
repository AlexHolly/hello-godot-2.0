extends Sprite

var dir = 1
var speed = 200
var damage = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if damage != 0:
		var s = Vector2(cos(deg2rad(dir)), -sin(deg2rad(dir)))*speed
		self.translate( s*delta )
	else:
		queue_free()

func _on_BulletColli_body_enter( body ):
	print(body.get_name())
	if body.get_name().begins_with("WallColli"):
		damage = 0
	elif body.get_name().begins_with("BrickColli"):
		body.get_parent().hit(damage)
		damage = 0
	elif body.get_name().begins_with("PlayerColli"):
		body.hit(damage)
		damage = 0
