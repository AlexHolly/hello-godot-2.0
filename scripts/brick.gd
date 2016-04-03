
extends Sprite

var item_hp = preload ("res://scenes/hp.scn")
var item_ammo = preload ("res://scenes/ammo.scn")

var items = [item_hp, item_ammo]

var item = null

var show_0 = preload("res://textures/stein0.png")
var show_1 = preload("res://textures/stein1.png")
var show_2 = preload("res://textures/stein2.png")

var img = [show_2, show_1, show_0]

func _ready():
	item = items[randi() % items.size()]
	randomize()
	if typeof(item) != TYPE_INT:
		item = item.instance()
		var item_colli = item.get_node(str(item.get_name(), "Colli"))
		
		#Make unique, solve collision problems
		var item_colli_name = str(item_colli, item.get_instance_ID())
		item_colli.set_name(item_colli_name)
		item.set_global_pos(self.get_pos())
		set_fixed_process(true)
	
func _fixed_process(delta):
	get_parent().add_child(item)
	set_fixed_process(false)
	
func hit(amount):
	var hp = get_node("ProgressBar")
	if hp.get_value() > 0:
		hp.set_value(hp.get_value()-amount)
		self.set_texture(img[hp.get_value()])
	else:
		if typeof(item) != TYPE_INT:
			item.pickable = true
		self.queue_free() 