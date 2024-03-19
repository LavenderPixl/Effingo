extends Node
var blue_done : bool = false
var pink_done : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var blue_max = get_tree().get_nodes_in_group("BlueGem").size()
	$HUD.setBlue($Player.score, blue_max)
	
	var pink_max = get_tree().get_nodes_in_group("PinkGem").size()
	$HUD.setPink($Player2.score, pink_max)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_blue_gem_collected():
	var blue_max = get_tree().get_nodes_in_group("BlueGem").size()
	$Player.score += 1	
	$HUD.setBlue($Player.score, blue_max)

func _on_pink_gem_collected():
	var pink_max = get_tree().get_nodes_in_group("PinkGem").size()
	$Player2.score += 1	
	$HUD.setPink($Player2.score, pink_max)
	
func first_button_pressed():
	$Button.pressed = true
	$MetalPlatform.height


func _on_button_btn_press():
	pass
