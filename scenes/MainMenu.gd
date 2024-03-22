extends Node2D

signal host_pressed
signal join_pressed
signal coop

func _on_host_pressed():
	host_pressed.emit(1)

func _on_join_pressed():
	join_pressed.emit(2)

func _on_couchcoop_pressed():
	coop.emit()

func _on_quit_game_pressed():
	get_tree().quit()
