
extends KinematicBody2D

#attributes
var speed = 100
var ammo = 10
var dir = Vector2(0,0)
var last_dir = Vector2(0,0)

func _ready():
	get_node("Label").set_text(str(ammo))
	set_fixed_process(true)
	
func _handle_move(delta):
	dir = Vector2(0, 0)
	if Input.is_action_pressed("move_left"):
		dir += Vector2(-1,0)
		last_dir = dir
	if Input.is_action_pressed("move_right"):
		dir += Vector2(1,0)
		last_dir = dir
	if Input.is_action_pressed("move_up"):
		dir += Vector2(0,-1)
		last_dir = dir
	if Input.is_action_pressed("move_down"):
		dir += Vector2(0,1)
		last_dir = dir
	
	get_node("Player").set_rot(atan2(-last_dir.y, last_dir.x))
	
	var motion = dir * speed * delta
	self.move( motion )

	
func _fixed_process(delta):
	_handle_move(delta)
	_handle_shoot()

#--shoot--
var bullet_class = preload("res://scenes/bullet.scn")

func _handle_shoot():
	if ammo > 0 && Input.is_action_pressed("shoot") && get_node("ShootTimer").ready:
		add_ammo(-1)
		var bullet = bullet_class.instance()
		bullet.set_name(str(bullet.get_name(), bullet.get_instance_ID()))
		var offset = get_pos() + (Vector2(25,25)*last_dir)
		bullet.set_pos(offset)
		bullet.dir = last_dir
		get_parent().add_child(bullet)
		get_node("ShootTimer").ready = false
		get_node("ShootTimer").start()
	
func hit(amount):
	var bar = get_node("ProgressBar")
	bar.set_value(bar.get_value()-amount)
	if bar.get_value() <= 0:
		queue_free()
		
func heal(amount):
	var bar = get_node("ProgressBar")
	bar.set_value(bar.get_value()+amount)
	if bar.get_value() > bar.get_max():
		bar.set_value(bar.get_max())

func add_ammo(amount):
	ammo+=amount
	get_node("Label").set_text(str(ammo))