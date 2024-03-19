extends Node
var blue_done : bool = false
var blue_max
var pink_done : bool = false
var pink_max

# Called when the node enters the scene tree for the first time.
func _ready():
	blue_max = get_tree().get_nodes_in_group("BlueGem").size()
	$HUD.setBlue($Player.score, blue_max)
	
	pink_max = get_tree().get_nodes_in_group("PinkGem").size()
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

func _on_area_2d_body_entered(body):
	if body == $Player2 and $Player2.score == pink_max:
		pink_done = true
		if blue_done and pink_done:
			_finished()
	if body == $Player and $Player.score == blue_max:
		blue_done = true
		if blue_done and pink_done:
			_finished()

func _on_area_2d_body_exited(body):
	if body == $Player2:
		pink_done = false
	if body == $Player:
		blue_done = false

func _finished():
	if pink_done and blue_done:
		get_tree().change_scene_to_file("res://scenes/SecondLevel.tscn")
