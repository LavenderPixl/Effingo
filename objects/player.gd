extends CharacterBody2D
class_name Player
@export var playerId: int
@export var speed = 300
@export var isRight : bool = true
@export var score = 0
@export var color: Globals.COLOR
@export var animation = "";

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.flip_h = isRight
	#if color == 0:
		#playerId = 1
	#elif color == 1:
		#playerId = 2
	
	if playerId == 1:
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, true)
		
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, true)
	elif playerId == 2:
		set_collision_layer_value(1, true)
		set_collision_layer_value(3, true)
		
		set_collision_mask_value(1, true)
		set_collision_mask_value(3, true)

func get_color(color: Globals.COLOR) -> String:
	return Globals.get_color(color)

func _physics_process(delta):
	if playerId == 0:
		return;
		
	$AnimatedSprite2D.flip_h = isRight
	if not is_multiplayer_authority():
		$AnimatedSprite2D.play(animation)
		return
	
	var input_prefix = "pl" + str(playerId) + "_"
	
	var input_color = get_color(color)
	if multiplayer.multiplayer_peer != null:
		input_prefix = "pl1_"
	
	if not is_on_floor():
		velocity.y += (gravity * delta) * 2
		
	if is_on_floor() and velocity.x == 0:
		$AnimatedSprite2D.play("%s_idle" %[input_color])
		velocity.x = 0
	
	if Input.is_action_just_pressed("close_game"):
		get_tree().quit()
	
	velocity.x = 0
	if Input.is_action_pressed(input_prefix + "move_right"):
		velocity.x = speed
		$AnimatedSprite2D.animation = "%s_walk" %[input_color]
		isRight = true

	if Input.is_action_pressed(input_prefix + "move_left"):
		velocity.x =  -speed
		$AnimatedSprite2D.animation = "%s_walk" %[input_color]
		isRight = false
		
	if Input.is_action_just_pressed(input_prefix + "jump") and is_on_floor():
		velocity.y -= 700
		$AnimatedSprite2D.play("%s_jump" %[input_color])
		
	if velocity.y > 0 and $AnimatedSprite2D.animation != ("%s_fall" %[input_color]):
		$AnimatedSprite2D.play("%s_fall" %[input_color])
	animation = $AnimatedSprite2D.animation
	move_and_slide()

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	var papa = get_parent();
	if is_multiplayer_authority():
		playerId = get_parent().playerId
		color = Globals.color_to_enum(playerId)
		position = get_tree().current_scene.find_child("Spawn").position
