extends Node

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
var playerId = 0

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	if id == 1:
		player.playerId = 1
		
	call_deferred("add_child", player)

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMenu.visible = true
	$FirstLevel.visible = false
	#

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_game():
	$MainMenu.visible = false
	$FirstLevel.visible = true

func _on_main_menu_host_pressed(player_id):
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	playerId = player_id
	#For the host to play!
	_add_player()
	start_game()

func _on_main_menu_join_pressed(player_id):
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	playerId = player_id
	start_game()
