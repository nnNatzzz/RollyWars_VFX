extends StaticBody2D

onready var def_layer = collision_layer
var connected_player = null

enum Effects{NOTHING,PULL,PUSH,FAST,SLOW}

export (Effects) var effect = Effects.NOTHING # setget set_effect

func set_effect(value):
	effect = value
	$EffectSpritePlacholder.text = Effects.keys()[effect]

func _ready():
	randomize()
	set_effect(get_random_effect())

func get_random_effect():
	var new_effect = randi() % (Effects.values().size())
	return new_effect

func connect_player(player):
	connected_player = player

func disconnect_player():
	connected_player = null

func deactivate():
	collision_layer = 0
	if connected_player != null:
		connected_player.get_node("Hookshot").detach()
	$Sprite.modulate.a = 0.2
	$DeactivationTimer.start()

func _on_DeactivationTimer_timeout():
	set_effect(get_random_effect())
	collision_layer = def_layer
	$Sprite.modulate.a = 1
