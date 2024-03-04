class_name Player
extends CharacterBody2D

@export var walk_speed : float = 50


@onready var lower_body : Node2D = $LowerBody
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var flashlight_animation = $FlashlightAnimation
@onready var stamina_bar : TextureProgressBar = $CanvasLayer/UI/StaminaBar


signal state_change(state_name : StringName)
var dir : Vector2
var restore_stamina : bool = false
var is_flashlight_on : bool = true
var run_speed : float = 0


func _physics_process(delta):
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	velocity = dir.normalized() * (walk_speed + run_speed)
	if velocity == Vector2.ZERO:
		animation_player.stop()
		emit_signal("state_change", "PlayerIdle")
	if stamina_bar.value == stamina_bar.max_value:
		restore_stamina = false
	if restore_stamina:
		stamina_bar.value += 2
	move_and_slide()


 # TODO smooth head, torso, legs rotation
 # TODO flashlight, hand movement


func _on_stamina_restore_timer_timeout():
	restore_stamina = true


func change_flashlight_mode() -> void:
	is_flashlight_on = !is_flashlight_on
