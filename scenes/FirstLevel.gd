extends Node
var blue_done : bool = false
var blue_max
var pink_done : bool = false
var pink_max


# Called when the node enters the scene tree for the first time.
func _ready():
	blue_max = count_gems(Globals.COLOR.BLUE)
	$HUD.setBlue($Player.score, blue_max)
	
	pink_max = count_gems(Globals.COLOR.PINK)
	$HUD.setPink($Player2.score, pink_max)


func count_gems(color: Globals.COLOR) -> int:
	var gems = get_tree().get_nodes_in_group("Gem")
	var count = 0
	for gem in gems:
		if gem.color == color:
			count += 1
	return count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_blue_gem_collected():
	$Player.score += 1
	$HUD.setBlue($Player.score, blue_max)

func _on_pink_gem_collected():
	$Player2.score += 1
	$HUD.setPink($Player2.score, pink_max)

func _on_area_2d_body_entered(body):
	if body == $Player2:
		pink_done = true
		if blue_done and pink_done:
			_finished()
	if body == $Player:
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
