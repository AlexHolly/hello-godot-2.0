
extends RigidBody2D

var speed = 20000
var currSpeed = 0

var LEFT_DIR = 180
var RIGHT_DIR = 0
var UP_DIR = 90
var DOWN_DIR = 270

var DR_DIR = 315
var DL_DIR = 225
var UR_DIR = 45
var UL_DIR = 135

var dir = RIGHT_DIR

var move_left = 0
var move_right = 0
var move_up = 0
var move_down = 0

func _handle_Multible_directions():
	print("")
	
func _handle_move(delta):
	move_left = Input.is_action_pressed("move_left")
	move_right = Input.is_action_pressed("move_right")
	
	move_up = Input.is_action_pressed("move_up")
	move_down = Input.is_action_pressed("move_down")
	
	currSpeed = speed
	if lastKey > 5:
		if twoKeys == 10:
			dir = DL_DIR
		elif twoKeys == 11:
			dir = DR_DIR
		elif lastKey == 7 && lastKey == 8:
			dir = UR_DIR
		elif lastKey == 6 && lastKey == 8:
			dir = UL_DIR
		elif lastKey == 6:
			dir = LEFT_DIR
		elif lastKey == 7:
			dir = RIGHT_DIR
		elif lastKey == 8:
			dir = UP_DIR
		elif lastKey == 9:
			dir = DOWN_DIR
	elif move_left:
		dir = LEFT_DIR
	elif move_right:
		dir = RIGHT_DIR
	elif move_up:
		dir = UP_DIR
	elif move_down:
		dir = DOWN_DIR
	else:
		currSpeed = 0
	
	get_node("Player").set_rot(deg2rad(dir))
	
	curr_dir = Vector2(cos(deg2rad(dir)), -sin(deg2rad(dir)))
	var s = curr_dir*currSpeed
	self.set_linear_velocity( s*delta )

var curr_dir = 0

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	_handle_move(delta)
	_handle_shoot()
	
var twoKeys = 0
var lastKey = 0

func _input(event):
	# keyboard events will send echo
	if event.is_action("move_down") && lastKey == 6 && event.is_pressed() && !event.is_echo():
		twoKeys = 10
	elif event.is_action("move_left") && lastKey == 6 && event.is_pressed() && !event.is_echo():
		twoKeys = 10
	elif lastKey == 9 && event.is_action("move_right") && event.is_pressed() && !event.is_echo():
		twoKeys = 11
	elif event.is_action("move_down") && lastKey == 7 && event.is_pressed() && !event.is_echo():
		twoKeys = 11
	elif event.is_action("move_left") && event.is_pressed() && !event.is_echo():
		lastKey = 6
	elif event.is_action("move_right") && event.is_pressed() && !event.is_echo():
		lastKey = 7
	elif event.is_action("move_up") && event.is_pressed() && !event.is_echo():
		lastKey = 8
	elif event.is_action("move_down") && event.is_pressed() && !event.is_echo():
		lastKey = 9
	if event.is_action("move_down") && lastKey != 6 && !event.is_pressed() && !event.is_echo():
		twoKeys = 0
	if event.is_action("move_down") && lastKey != 7 && !event.is_pressed() && !event.is_echo():
		twoKeys = 0
	if event.is_action("move_left") && !event.is_pressed() && !event.is_echo():
		lastKey = 0
	if event.is_action("move_right") && !event.is_pressed() && !event.is_echo():
		lastKey = 0
	if event.is_action("move_up") && !event.is_pressed() && !event.is_echo():
		lastKey = 0
	if event.is_action("move_down") && !event.is_pressed() && !event.is_echo():
		lastKey = 0

#--shoot--
var bullet_class = preload("res://scenes/bullet.scn")
func _handle_shoot():
	if Input.is_action_pressed("shoot") && get_node("ShootTimer").ready:
		var node = bullet_class.instance()
		node.set_name(str(node.get_name(), node.get_instance_ID()))
		var offset = get_pos() + (Vector2(25,25)*curr_dir)
		node.set_pos(offset)
		node.dir = dir
		get_parent().add_child(node)
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