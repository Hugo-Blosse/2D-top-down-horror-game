class_name Player
extends CharacterBody2D

@export var walk_speed : float = 50


@onready var lower_body : Node2D = $LowerBody
@onready var upper_body : Node2D = $UpperBody
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var flashlight_animation = $FlashlightAnimation
@onready var stamina_bar : TextureProgressBar = $CanvasLayer/UI/MarginContainer/StaminaBar
@onready var state_machine :StateMachine = $StateMachine
@onready var player_sound_area = %PlayerSoundArea
@onready var hide_timer : Timer = $StateMachine/PlayerHide/HideTimer


signal state_change(state_name : StringName)


var dir : Vector2
var restore_stamina : bool = false
var is_flashlight_on : bool = true
var run_speed : float = 0
var is_hidden : bool = false
var focused : bool = false

func _physics_process(delta):
	velocity = dir.normalized() * (walk_speed + run_speed)
	if state_machine.current_state.name != "PlayerHide" && velocity == Vector2.ZERO && state_machine.current_state.name != "PlayerIdle":
		animation_player.stop()
		emit_signal("state_change", "PlayerIdle")
	if stamina_bar.value == stamina_bar.max_value:
		restore_stamina = false
	if restore_stamina:
		stamina_bar.value += 2
	move_and_slide()


# TODO death animation + effects
# TODO diaboł enemy
# OPTIMIZE flashlight & hand movement - light in wall
# OPTIMIZE smooth circle
# CHANGEABLE hide animation


func _on_stamina_restore_timer_timeout():
	restore_stamina = true


func change_flashlight_mode() -> void:
	is_flashlight_on = !is_flashlight_on


func hide_player():
	emit_signal("state_change", "PlayerHide")


func _on_focus_timer_timeout():
	focused = true


func _on_hide_timer_timeout():
	is_hidden = !is_hidden
