extends StaticBody2D
var disabled_position : Vector2
var enabled_position : Vector2
@export var distance : int = 0
var enabled : bool
@export var set_color : String

# Called when the node enters the scene tree for the first time.
func _ready():
	disabled_position = position
	enabled_position = disabled_position
	enabled_position.y -= distance
	_set_color(set_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enabled and position != enabled_position:
		position.y -= 0.01
	if not enabled and position != disabled_position:
		position.y += 0.01


func _set_color(color):
	$AnimatedSprite2D.play("%s" %[color])

func enable():
	enabled = true

func disable():
	enabled = false
