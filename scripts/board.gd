extends Node
class_name Board

var grid_board: Array
var ativo: bool = true
var winner: int
var moves: int
var num_reset:int = 0

signal chance_empate

func _init() -> void:
	moves = 0
	grid_board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	winner = 0

func move_occur(player, coordenadas):
	if grid_board[coordenadas] != 0:
		print(get_parent().name)
		print(grid_board)
		print_debug(coordenadas)
		get_tree().paused = true
		print_debug("Por que vim para aqui?")
	moves += 1
	grid_board[coordenadas] = player
	winner = Constantes.check_win(grid_board)
	if moves == 9 and winner == 0:
		reset()
	elif winner != 0:
		ativo = false
	return winner

func reset():
	moves = 0
	grid_board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	winner = 0
	ativo = true
	num_reset += 1
	if num_reset > 5:
		chance_empate.emit()

func set_ativo(ativado):
	ativo = ativado

func get_movimentos_possiveis() -> Array:
	var movimentos_possiveis = []
	for i in range(9):
		if grid_board[i] == 0:
			movimentos_possiveis.append(i)
	return movimentos_possiveis
