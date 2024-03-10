extends Node2D


@onready var breaker_area : Area2D = $BreakerArea
@onready var player : Player
@onready var breaker_animation : AnimationPlayer = $BreakerAnimation


signal switch()


# TODO switch lights on/off
# TODO react to player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _input(event):
	if breaker_animation.is_playing():
		return
	if breaker_area.overlaps_body(player) && Input.is_action_just_pressed("interact"):
		if $Sprite2D.frame == 9:
			breaker_animation.play("switch_on")
			return
		breaker_animation.play("switch_off")


func _switch() -> void:
	emit_signal("switch")
