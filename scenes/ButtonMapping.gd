extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	if multiplayer.multiplayer_peer == null and not is_multiplayer_authority():
		text = "Controls: \n Player 1: WASD \n Player 2: Arrow Keys"
	else: 
		text = "Controls: \n WASD"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
