class_name StateMachine
extends Node

@export var current_state : State

var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			child.state_machine = self
			states[child.name] = child
	if current_state != null:
		current_state.enter()

func on_state_change(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null && new_state != current_state:
		current_state.exit()
		new_state.enter()
		current_state = new_state

func _physics_process(delta):
	#print(current_state.name)
	current_state.physics_update(delta)
