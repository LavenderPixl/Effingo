extends CharacterBody2D

@export var playerId: int = 1
@export var speed = 300
@export var gravity = 400
@export var isRight : bool = true

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.flip_h = isRight
	
func _process(delta):	
	var input_prefix = "pl" + str(playerId) + "_"
	
	if not is_on_floor():
		velocity.y += (gravity * delta) * 2
		#velocity.y += (500 * delta) * 1.5
	
	if is_on_floor() and velocity.x == 0:
		$AnimatedSprite2D.play("idle")
	
	velocity.x = 0
	if Input.is_action_pressed("close_game"):
		get_tree().quit()
	
	if Input.is_action_pressed(input_prefix + "move_right"):
		velocity.x = speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true

	if Input.is_action_pressed(input_prefix + "move_left"):
		velocity.x =  -speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
	
	if Input.is_action_just_pressed(input_prefix + "jump") and is_on_floor():
		velocity.y -= 400
		$AnimatedSprite2D.play("jump")
	
	if velocity.y > 0 and $AnimatedSprite2D.animation != "fall":
		$AnimatedSprite2D.play("fall")
	
	move_and_slide()
