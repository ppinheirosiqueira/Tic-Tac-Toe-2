extends Control

var show_top : bool = true
var show_bottom : bool = true
var show_left : bool = true
var show_right : bool = true

@onready var borders: Control = $Borders

@onready var cell_0: Control = $Cell_0
@onready var cell_1: Control = $Cell_1
@onready var cell_2: Control = $Cell_2
@onready var cell_3: Control = $Cell_3
@onready var cell_4: Control = $Cell_4
@onready var cell_5: Control = $Cell_5
@onready var cell_6: Control = $Cell_6
@onready var cell_7: Control = $Cell_7
@onready var cell_8: Control = $Cell_8

@onready var celulas = [cell_0, cell_1, cell_2, cell_3, cell_4, cell_5, cell_6, cell_7, cell_8]

var winner:int = 0
var posicoes:Array = [0,0,0,0,0,0,0,0,0]
var ativo: bool = true
var moves: int
var num_reset:int = 0

signal chance_empate
signal tabuleiro_clicado

func _ready() -> void:
	borders.set_borders(get_rect().size[0], show_top, show_bottom, show_left, show_right)
	for cell in celulas:
		cell.connect("celula_clicada", _on_cell_clicada)

func _on_cell_clicada(index: int) -> void:
	if ativo:
		var nome = str(name)
		tabuleiro_clicado.emit(int(nome[-1]),index)

func move_occur(player:int , celula:int):
	celulas[celula].add_marker(player)
	moves += 1
	if posicoes[celula] != 0:
		print("Por favor, não apareça")
	posicoes[celula] = player
	winner = WinConditions.check_win(posicoes)
	if moves == 9 and winner == 0:
		reset()
	elif winner != 0:
		set_ativo(false)
		reset_markers_cell()
		add_marker()
	return winner

func reset_markers_cell() -> void:
	for celula in celulas:
		celula.remove_mark()
	
func add_marker() -> void:
	var scene
	if winner == 1:
		scene = Preferencias.cenas[Preferencias.choose_marker].instantiate()
	else:
		scene = Preferencias.cenas[-Preferencias.choose_marker].instantiate()
	scene.scale = Vector2(3,3)
	scene.name = "marker"
	add_child(scene)

func reset():
	moves = 0
	posicoes = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	for cell in celulas:
		cell.reset()
	num_reset += 1
	if num_reset > 5:
		chance_empate.emit()
		
func new_game():
	winner = 0
	num_reset = 0
	moves = 0
	posicoes = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	for cell in celulas:
		cell.reset()
	set_ativo(true)
	remove_mark()
	
func remove_mark() -> void:
	for child in get_children():
		if child.name == "marker":
			child.queue_free()
			break

func set_ativo(ativado):
	ativo = ativado
	$Fundo.color = Color(0, 0, 0, 0) if ativo else Color(0, 0, 0, 0.5)

func get_movimentos_possiveis() -> Array: # Para o aleatório
	var movimentos_possiveis = []
	for i in range(9):
		if posicoes[i] == 0:
			movimentos_possiveis.append(i)
	return movimentos_possiveis
