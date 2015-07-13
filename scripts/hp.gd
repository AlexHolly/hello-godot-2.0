
extends Sprite

var heal_amount = 20
var pickable = false

func _ready():
	# Initialization here
	pass

func _on_RigidBody2D_body_enter( body ):
	print(body.get_name())
	print(body != null)
	print(weakref(body).get_ref() != null)
	if body != null && weakref(body).get_ref() != null:
		if pickable && body.get_name().begins_with("Player"):
			print("aa")
			body.heal(heal_amount)
			queue_free()
		elif pickable && body.get_name().begins_with("Bullet"):
			body.queue_free()
			queue_free()
