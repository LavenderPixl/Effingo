extends Node

@export var player_scene: PackedScene
@export var levels: Array[PackedScene] = []
@export var current_level = 0

var peer = ENetMultiplayerPeer.new()
var playerId = 0

func _add_player(id = 1):
	playerId = id
	
	var player = player_scene.instantiate()
	
	player.name = str(id)
	player.playerId = id
	
	call_deferred("add_child", player)

func _ready():
	$MainMenu.visible = true

func next_level():
	var level = get_tree().get_first_node_in_group("level")
	if level:
		level.queue_free() 
	
	level = levels[current_level].instantiate()
	level.connect("level_complete", next_level)
	
	current_level += 1
	
	add_child(level)
	#Move players
	var players = get_tree().get_nodes_in_group("Players")
	for player in players:
		var spawn_point = "spawn_blue" if player.playerId == 1 else "spawn_pink"
		
		if player.is_multiplayer_authority() or multiplayer.multiplayer_peer == null:
			player.color = Globals.color_to_enum(player.playerId)
			
			player.global_position = get_tree().get_first_node_in_group(spawn_point).global_position
			player.velocity = Vector2.ZERO
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_game():
	$MainMenu.visible = false
	#$FirstLevel.visible = true
	next_level()

func _on_main_menu_host_pressed(player_id):
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	playerId = player_id
	#For the host to play!
	start_game()
	_add_player()

func _on_main_menu_join_pressed(player_id):
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	playerId = player_id
	start_game()

func _on_main_menu_coop():
	multiplayer.multiplayer_peer = null
	start_game()
	_add_player(1)
	_add_player(2)

func _on_first_level_finished_first():
	$Level.queue_free()
	$SecondLevel.instansiate()
