extends StaticBody2D
@export var pressed : bool = false
signal btnPress

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressable_body_entered(body):
	pressed = true
	btnPress.emit()
