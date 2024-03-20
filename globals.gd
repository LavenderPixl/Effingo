extends Node

enum COLOR { BLUE, PINK }

func get_color(color) -> String:
	if color == Globals.COLOR.BLUE:
		return "blue"
	elif color == Globals.COLOR.PINK:
		return "pink"
	return ""
