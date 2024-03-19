extends StaticBody2D
@export var pressed : bool = false
@export var platform : Node2D
@export var set_color : String
signal btnPress

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_color(set_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressable_body_entered(body):
	if not body.is_in_group("Players"):
		return
	pressed = true
	btnPress.emit()
	print(pressed)
	platform.enable()

func _set_color(color):
	$AnimatedSprite2D.play("%s_idle" %[color])


func _on_button_pressable_body_exited(body):
	if not body.is_in_group("Players"):
		return
	platform.disable()
