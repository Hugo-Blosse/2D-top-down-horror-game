class_name Light
extends Node2D


func switch_light() -> void:
	$Light.enabled = !$Light.enabled
	$Area2D/CollisionShape2D.disabled = !$Area2D/CollisionShape2D.disabled
