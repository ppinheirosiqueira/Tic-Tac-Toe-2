extends Control

@export var circle_scene:PackedScene
@export var cross_scene:PackedScene

@export var show_top : bool = false
@export var show_bottom : bool = false
@export var show_left : bool = false
@export var show_right : bool = false

@onready var borders: Control = $Borders

var marcado:int = 0

signal celula_clicada

func _ready():
	scale = get_parent().scale
	remove_mark()
	borders.set_borders(get_rect().size[0], show_top, show_bottom, show_left, show_right)

func add_marker(player:int) -> void:
	var scene
	marcado = player
	if player == 1:
		scene = circle_scene.instantiate()
	else:
		scene = cross_scene.instantiate()
	scene.name = "marker"
	add_child(scene)

func reset() -> void:
	remove_mark()
	marcado = 0

func remove_mark() -> void:
	for child in get_children():
		if child.name == "marker":
			child.queue_free()
			break

func _on_fundo_pressed() -> void:
	if marcado == 0:
		var nome = str(name)
		celula_clicada.emit(int(nome[-1]))
