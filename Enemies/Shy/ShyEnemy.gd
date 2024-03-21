extends CharacterBody2D


signal player_kill()
signal state_change(state_name : StringName)


var player : Player
var scene
var detection_started : bool = false
