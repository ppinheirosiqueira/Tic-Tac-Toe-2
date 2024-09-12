extends Sprite2D

@export var circle_scene: PackedScene
@export var cross_scene: PackedScene

var tabuleiro:Board = Board.new()

@export var show_top : bool = false
@export var show_bottom : bool = false
@export var show_left : bool = false
@export var show_right : bool = false

func _ready():
	remove_markers()
	set_ativo(true)
	$Borders/TopBorder.visible = show_top
	$Borders/BottomBorder.visible = show_bottom
	$Borders/LeftBorder.visible = show_left
	$Borders/RightBorder.visible = show_right

func remove_markers() -> void:
	for child in get_children():
		if child.is_in_group("markers"):
			child.queue_free()
			
func move_occur(player, coordenadas):
	create_marker(Vector2(200*Constantes.grid_correspondence[coordenadas][0] + 100,200*Constantes.grid_correspondence[coordenadas][1] + 100), player)
	if tabuleiro.move_occur(player,coordenadas) != 0:
		$Borders/CenterPanel.modulate = Color(0, 0, 0, 0.8)
		for child in get_children():
			if child.is_in_group("markers"):
				child.queue_free()
	elif tabuleiro.moves == 0:
		reset()
	return tabuleiro.winner
	
func reset():
	tabuleiro.reset()
	remove_markers()
	set_ativo(true)

func set_ativo(ativado):
	tabuleiro.set_ativo(ativado)
	if tabuleiro.ativo:
		$Borders/CenterPanel.modulate = Color(0, 0, 0, 0)
	else:
		$Borders/CenterPanel.modulate = Color(0, 0, 0, 0.8)

func create_marker(marker_position, player):
	var scene
	if player == 1:
		scene = circle_scene.instantiate()
	else:
		scene = cross_scene.instantiate()
	scene.position = marker_position
	scene.scale = Vector2(1.75,1.75)
	add_child(scene)
