extends Node

enum COLOR { UNDEFINED, BLUE, PINK }
var online : bool = false

func get_color(color) -> String:
	if color == Globals.COLOR.BLUE:
		return "blue"
	elif color == Globals.COLOR.PINK:
		return "pink"
	return ""
func color_to_enum(color: int) -> Globals.COLOR:
	if color == 1:
		return Globals.COLOR.BLUE
	elif color == 2:
		return Globals.COLOR.PINK
	return COLOR.UNDEFINED
#func _set_game_mode():
	#if online:
		#InputMap.add_action("jump")
		#var e = new InputEventKey
		#e.set("scancode", KeyList.A)
		#InputMap.action_add_event("jump", e)
	#else: 
		#return
