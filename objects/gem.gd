extends Area2D

@export var message: String = ""
var gemCollected = false
var shine_cooldown = 0
signal collected(gemCollected)

func _ready():
	$Message.text = message
	$AnimatedSprite2D.play("idle")

func _process(delta):
	if shine_cooldown == 0:
		#$AnimatedSprite2D.play("idle")
		if randi_range(0, 4000) == 382:
			$AnimatedSprite2D.play("shine")
			shine_cooldown = 1
	else:
		if shine_cooldown >= 0:
			shine_cooldown -= delta
		else:
			shine_cooldown = 0
	

func _on_body_entered(body):
	if body.is_in_group("Players"):
		gemCollected = true
		collected.emit()
		queue_free()
		#visible = false

func _shine_anim():
	var shine_timer = randf_range(10.0, 30.0)
	await (get_tree().create_timer(shine_timer)).timeout
	
	print("SHINE!")
	$AnimatedSprite2D.play("shine")
	await (get_tree().create_timer(20)).timeout
	$AnimatedSprite2D.play("idle")
	print("Not shining anymore")
