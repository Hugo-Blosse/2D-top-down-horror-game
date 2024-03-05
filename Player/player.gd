class_name Player
extends CharacterBody2D

@export var walk_speed : float = 50


@onready var lower_body : Node2D = $LowerBody
@onready var upper_body : Node2D = $UpperBody
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var flashlight_animation = $FlashlightAnimation
@onready var stamina_bar : TextureProgressBar = $CanvasLayer/UI/StaminaBar
@onready var state_machine :StateMachine = $StateMachine


signal state_change(state_name : StringName)
var dir : Vector2
var restore_stamina : bool = false
var is_flashlight_on : bool = true
var run_speed : float = 0


func _physics_process(delta):
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	velocity = dir.normalized() * (walk_speed + run_speed)
	if velocity == Vector2.ZERO && state_machine.current_state.name != "PlayerIdle":
		animation_player.stop()
		emit_signal("state_change", "PlayerIdle")
	if stamina_bar.value == stamina_bar.max_value:
		restore_stamina = false
	if restore_stamina:
		stamina_bar.value += 2
	move_and_slide()


# OPTIMIZE smooth head, torso, legs rotation - it's kinda smooth(?)
# OPTIMIZE flashlight & hand movement
# OPTIMIZE run animation
# TODO sounds detection
# TODO death animation + effects
# TODO hide animation + effects + objects
# TODO diaboł enemy


func _on_stamina_restore_timer_timeout():
	restore_stamina = true


func change_flashlight_mode() -> void:
	is_flashlight_on = !is_flashlight_on
