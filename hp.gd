
extends Sprite

var heal_amount = 1
var pickable = false

func _ready():
	# Initialization here
	pass

func _on_RigidBody2D_body_enter( body ):
	if pickable && body.get_name().begins_with("Player"):
		body.heal(heal_amount)
		queue_free()
	elif pickable && body.get_name().begins_with("Bullet"):
		body.damage = 0
		queue_free()
