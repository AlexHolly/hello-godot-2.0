extends Sprite

var dir = Vector2(0,0)
var speed = 200
var damage = 1
var owner = -1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if damage != 0:
		self.translate( dir * speed * delta )
	else:
		queue_free()

func _on_BulletColli_body_enter( body ):
	
	if body.get_name().begins_with("WallColli"):
		damage = 0
	elif body.get_name().begins_with("BrickColli"):
		body.get_parent().hit(damage)
		damage = 0
	elif body.get_name().begins_with("PlayerColli"):
		if(owner!=body.id):
			body.hit(damage)
			damage = 0

func hit_me(body):
	body.hit(damage)
	damage = 0
