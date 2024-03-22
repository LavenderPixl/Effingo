extends Area2D

@export var message: String = ""
@export var color: Globals.COLOR = Globals.COLOR.BLUE

var gemCollected = false
var shine_cooldown = 0

signal collected(gemCollected)

func _ready():
	$Message.text = message
	$AnimatedSprite2D.play("%s_idle" %[get_color(color)])

func get_color(color) -> String:
	return Globals.get_color(color)

func _process(delta):
	if shine_cooldown == 0:
		#$AnimatedSprite2D.play("idle")
		if randi_range(0, 4000) == 382:
			$AnimatedSprite2D.play("%s_shine" %[get_color(color)])
			shine_cooldown = 1
	else:
		if shine_cooldown >= 0:
			shine_cooldown -= delta
		else:
			shine_cooldown = 0

func _on_body_entered(body):
	
	if body.is_in_group("Players"):
		if multiplayer.multiplayer_peer == null:
			collect_gem()
		else:
			collect_gem.rpc()
@rpc("any_peer","call_local")
func collect_gem():
	print(1)
	gemCollected = true
	collected.emit()
	queue_free()

func _shine_anim():
	var shine_timer = randf_range(10.0, 30.0)
	await (get_tree().create_timer(shine_timer)).timeout
	
	$AnimatedSprite2D.play("%s_shine" %[get_color(color)])
	await (get_tree().create_timer(20)).timeout
	$AnimatedSprite2D.play("%s_idle" %[get_color(color)])
