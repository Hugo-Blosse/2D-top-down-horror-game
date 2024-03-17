extends Node2D


func _ready():
	$Breaker.switch.connect(_switch_lights)
	for enemy in $Enemies.get_children():
		enemy.scene = self

func _switch_lights() -> void:
	for light in $Lights.get_children():
		if light is Light:
			light.switch_light()
