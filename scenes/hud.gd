extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setBlue(blue_score, blue_max): 
	$BlueScoreLabel.text = "%s / %s" %[blue_score, blue_max]

func setPink(pink_score, pink_max):
	$PinkScoreLabel.text = "%s / %s" %[pink_score, pink_max]

func _on_start_button_pressed():
	get_tree().quit()
