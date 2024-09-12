extends Control
class_name Celula

@export var circle_scene:PackedScene
@export var cross_scene:PackedScene

@export var show_top : bool = false
@export var show_bottom : bool = false
@export var show_left : bool = false
@export var show_right : bool = false

@onready var borders: Control = $Borders

func _ready():
	remove_mark()
	borders.set_borders(get_rect().size[0], show_top, show_bottom, show_left, show_right)
	borders.set_fundo(true)
	
func add_marker(player:int) -> void:
	var scene
	if player == 1:
		scene = circle_scene.instantiate()
	else:
		scene = cross_scene.instantiate()
	scene.name = "marker"
	add_child(scene)

func remove_mark() -> void:
	for child in get_children():
		if child.name == "marker":
			child.queue_free()
			break
