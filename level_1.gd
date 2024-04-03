extends Node2D


func _ready():
	$Breaker.switch.connect(_switch_lights)
	$Enemies/Syh.breaker = $Breaker
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.scene = self
	for light in $Lights.get_children():
		#light.shy_enemy =
		pass 


func _switch_lights() -> void:
	for light in $Lights.get_children():
		if light is Light:
			light.switch_light()
