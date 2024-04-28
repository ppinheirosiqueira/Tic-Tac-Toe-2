extends Node

@export var circle_scene: PackedScene 
@export var cross_scene: PackedScene 

var size_board: int
var size_cell: int
var grid_pos: Vector2i
var what_board: Vector2i
var player: int
var temp_marker
var player_panel_pos: Vector2i
var big_board: Array
var big_winner: int
var vitorias: Array
var player_inicial: int

func _ready():
	$RegrasWindow.hide()
	size_board = $Board_0_0.texture.get_width()*$Board_0_0.scale.x
	@warning_ignore("integer_division")
	size_cell = size_board / 3
	player_panel_pos = Vector2i(%PlayerPanel.global_position) + Vector2i(30,247)
	vitorias = [0, 0, 0]
	player_inicial = -1
	new_game()

func new_game():
	$GameOverMenu.hide()
	player = player_inicial*-1
	player_inicial = player
	get_tree().call_group("circles", "queue_free")
	get_tree().call_group("crosses", "queue_free")
	big_winner = 0
	big_board = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
	create_marker(player_panel_pos + Vector2i(115, 100), true)
	for i in range(3):
		for j in range(3):
			var aux = "Board_" + str(i) + "_" + str(j)
			var grid = get_node(aux)
			grid.set_ativo(true)
			grid.reset()
	get_tree().paused = false

@warning_ignore("shadowed_variable_base_class")
func create_marker(position, temp=false):
	var scene
	if player == 1:
		scene = circle_scene.instantiate()
	else:
		scene = cross_scene.instantiate()
	scene.scale = Vector2(2.5, 2.5)
	scene.position = position
	scene.add_to_group("markers")
	if temp: 
		scene.scale = Vector2(1.75, 1.75)
		temp_marker = scene
	add_child(scene)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.position.x <= 3*size_board:
			what_board = event.position / size_board
			grid_pos = (Vector2i(event.position) - what_board*size_board )/ size_cell
			var board = get_node("Board_" + str(what_board[0]) + "_" + str(what_board[1]))
			if board.ativo and board.grid_board[grid_pos.y][grid_pos.x] == 0:
				big_board[what_board[0]][what_board[1]] = board.move_occur(player, grid_pos)
				ativar_grid(grid_pos)
				if big_board[what_board[0]][what_board[1]] != 0:
					create_marker(what_board*size_board + Vector2i(150, 150), false)
				big_winner = check_win()
				if big_winner != 0 or check_draw():
					attVitorias()
					get_tree().paused = true
					$GameOverMenu.show()
				player *= -1
				temp_marker.queue_free()
				create_marker(player_panel_pos + Vector2i(115, 100), true)

func check_win() -> int:
	var win_condition
	win_condition = big_board[0][0] + big_board[1][1] + big_board[2][2]
	if win_condition == 3 or win_condition == -3:
		return win_condition/3
	win_condition = big_board[2][0] + big_board[1][1] + big_board[0][2]
	if win_condition == 3 or win_condition == -3:
		return win_condition/3
		
	for i in range(3):
		win_condition = big_board[i][0] + big_board[i][1] + big_board[i][2]
		if win_condition == 3 or win_condition == -3:
			return win_condition/3
			
		win_condition = big_board[0][i] + big_board[1][i] + big_board[2][i]
		if win_condition == 3 or win_condition == -3:
			return win_condition/3
	return 0

func attVitorias():
	if big_winner == 1:
		vitorias[0] = vitorias[0] + 1
		%Player1ScoreLabel.text = str(vitorias[0])
		$GameOverMenu/WinLabel.text = "Jogador 1 venceu"
	elif big_winner == -1:
		vitorias[1] = vitorias[1] + 1
		%Player2ScoreLabel.text = str(vitorias[1])
		$GameOverMenu/WinLabel.text = "Jogador 2 venceu"
	else:
		vitorias[2] = vitorias[2] + 1
		%DrawScoreLabel.text = str(vitorias[2])
		$GameOverMenu/WinLabel.text = "Empate"

func check_draw() -> bool:
	var diag1 = range(3).map(func(n): return big_board[n][n])
	var diag2 = range(3).map(func(n): return big_board[n][2-n])
	if not (1 in diag1 and -1 in diag1) or not (1 in diag2 and -1 in diag2):
		return false
	
	for i in range(3):
		if not (1 in big_board[i] and -1 in big_board[i]):
			return false
		var col = range(3).map(func(n): return big_board[n][i])
		if not (1 in col and -1 in col):
			return false
	return true

func ativar_grid(coordenadas):
	var att_board = get_node("Board_" + str(coordenadas[0]) + "_" + str(coordenadas[1]))
	if att_board.winner != 0:
		for i in range(3):
			for j in range(3):
				var other_boards = get_node("Board_" + str(i) + "_" + str(j))
				if other_boards.winner == 0:
					other_boards.set_ativo(true)
		return 
	for i in range(3):
		for j in range(3):
			var other_boards = get_node("Board_" + str(i) + "_" + str(j))
			other_boards.set_ativo(false)
	att_board.set_ativo(true)
	
func _on_game_over_menu_restart():
	new_game()

func _on_regras_window_close_requested():
	$RegrasWindow.hide()
	get_tree().paused = false
					
func _on_button_pressed():
	$RegrasWindow.show()
	get_tree().paused = true
