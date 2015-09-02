
extends Sprite

var amount = 8
var pickable = false

func _ready():
	pass
	
func _on_HPColli_body_enter( body ):
	print(body.get_name())
	if pickable && body.get_name().begins_with("Player"):
		body.add_ammo(amount)
		queue_free()
	elif pickable && body.get_name().begins_with("BulletColli"):
		body.get_parent().hit_me(self)

func hit(amount):
	var hp = get_node("ProgressBar")
	if hp.get_value()-amount > 0:
		hp.set_value(hp.get_value()-amount)
	else:
		self.queue_free() 