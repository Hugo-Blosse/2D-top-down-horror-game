extends Path2D


@onready var path_follow_2d : PathFollow2D = $PathFollow2D
@onready var ogre_transform = $PathFollow2D/OgreTransform


var ogre_rotation : float = 0
var speed : float = 100


func _process(delta):
	path_follow_2d.progress += speed * delta


func _physics_process(delta):
	ogre_transform.rotation += ogre_rotation


func _on_ogre_change_path_speed(new_speed : float):
	speed = new_speed


func _on_ogre_change_rotation(new_rotation : float):
	ogre_rotation = new_rotation
