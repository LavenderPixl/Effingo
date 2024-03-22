extends Node2D

var blue_done : bool = false
@export var blue_collected = 0
var blue_max
var pink_done : bool = false
@export var pink_collected = 0
var pink_max

signal level_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	blue_max = count_gems(Globals.COLOR.BLUE)
	pink_max = count_gems(Globals.COLOR.PINK)

func count_gems(color: Globals.COLOR) -> int:
	var gems = get_tree().get_nodes_in_group("Gem")
	var count = 0
	for gem in gems:
		if gem.color == color:
			count += 1
	return count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	$HUD.setBlue(blue_collected, blue_max)
	$HUD.setPink(pink_collected, pink_max)

func _on_blue_gem_collected():
	blue_collected += 1

func _on_pink_gem_collected():
	pink_collected += 1

func _on_area_2d_body_entered(body):
	if not body is Player:
		return
	if body.color == Globals.COLOR.BLUE:
		blue_done = true
	if body.color == Globals.COLOR.PINK:
		pink_done = true
	if blue_done and pink_done:
		_finished()

func _on_area_2d_body_exited(body):
	if not body is Player:
		return
	if body.color == Globals.COLOR.PINK:
		pink_done = false
	if body.color == Globals.COLOR.BLUE:
		blue_done = false

func _finished():
	if pink_done and blue_done:
		level_complete.emit()
