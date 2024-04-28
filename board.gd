extends Sprite2D

@export var circle_scene: PackedScene
@export var cross_scene: PackedScene

var grid_board: Array
var ativo: bool = true
var winner: int
var moves: int

@export var show_top : bool = false
@export var show_bottom : bool = false
@export var show_left : bool = false
@export var show_right : bool = false

func _ready():
	ativo = true
	reset()
	
	$Borders/TopBorder.visible = show_top
	$Borders/BottomBorder.visible = show_bottom
	$Borders/LeftBorder.visible = show_left
	$Borders/RightBorder.visible = show_right
	
func check_win() -> int:
	var win_condition
	win_condition = grid_board[0][0] + grid_board[1][1] + grid_board[2][2]
	if win_condition == 3 or win_condition == -3:
		return win_condition/3
	win_condition = grid_board[2][0] + grid_board[1][1] + grid_board[0][2]
	if win_condition == 3 or win_condition == -3:
		return win_condition/3
		
	for i in range(3):
		win_condition = grid_board[i][0] + grid_board[i][1] + grid_board[i][2]
		if win_condition == 3 or win_condition == -3:
			return win_condition/3
			
		win_condition = grid_board[0][i] + grid_board[1][i] + grid_board[2][i]
		if win_condition == 3 or win_condition == -3:
			return win_condition/3
		
	return 0
	
func move_occur(player, coordenadas):
	moves += 1
	grid_board[coordenadas[1]][coordenadas[0]] = player
	create_marker(Vector2(200*coordenadas[0] + 100,200*coordenadas[1] + 100), player)
	winner = check_win()
	if moves == 9 and winner == 0:
		reset()
	elif winner != 0:
		ativo = false
		$Borders/CenterPanel.modulate = Color(0, 0, 0, 0.8)
		for child in get_children():
			if child.is_in_group("markers"):
				child.queue_free()
	return winner
	
func reset():
	moves = 0
	grid_board = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
	winner = 0
	for child in get_children():
		if child.is_in_group("markers"):
			child.queue_free()

func set_ativo(ativado):
	ativo = ativado
	if ativo:
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
