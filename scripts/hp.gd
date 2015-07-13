
extends Sprite

var heal_amount = 1
var pickable = false

func _ready():
	# Initialization here
	pass

func _on_HPColli_body_enter( body ):
	print(body.get_name())
	if pickable && body.get_name().begins_with("Player"):
		body.heal(heal_amount)
		queue_free()
	elif pickable && body.get_name().begins_with("BulletColli"):
		hit(body.get_parent().damage)
		body.get_parent().damage = 0

func hit(amount):
	var hp = get_node("ProgressBar")
	if hp.get_value()-amount > 0:
		hp.set_value(hp.get_value()-amount)
	else:
		self.queue_free() 