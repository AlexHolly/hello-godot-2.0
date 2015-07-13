
extends Timer

func _ready():
	# Initialization here
	pass

func _on_Range_Timer_timeout():
	get_parent().queue_free()
	pass # replace with function body
