extends Control

@onready var tabuleiro_0: Control = $Tabuleiro_0
@onready var tabuleiro_1: Control = $Tabuleiro_1
@onready var tabuleiro_2: Control = $Tabuleiro_2
@onready var tabuleiro_3: Control = $Tabuleiro_3
@onready var tabuleiro_4: Control = $Tabuleiro_4
@onready var tabuleiro_5: Control = $Tabuleiro_5
@onready var tabuleiro_6: Control = $Tabuleiro_6
@onready var tabuleiro_7: Control = $Tabuleiro_7
@onready var tabuleiro_8: Control = $Tabuleiro_8

@onready var tabuleiros = [tabuleiro_0, tabuleiro_1, tabuleiro_2, tabuleiro_3, tabuleiro_4, tabuleiro_5, tabuleiro_6, tabuleiro_7, tabuleiro_8]

var big_posicoes = [0,0,0,0,0,0,0,0,0]
var winner:int = 0
var player:int = 1
var player_inicial:int = 1

signal player_atual
signal end_game

func _ready() -> void:
	var screen_height = get_viewport().size.y
	var node_height = 1080
	if node_height > screen_height:
		var scale_factor = float(screen_height - 32) / node_height
		scale = Vector2(scale_factor, scale_factor)

	for tabuleiro in tabuleiros:
		tabuleiro.connect("tabuleiro_clicado", _on_tabuleiro_clicado)
		tabuleiro.connect("chance_empate", _on_check_empate)
		
func _on_tabuleiro_clicado(index_tabuleiro:int, index_celula:int) -> void:
	if tabuleiros[index_tabuleiro].ativo:
		big_posicoes[index_tabuleiro] = tabuleiros[index_tabuleiro].move_occur(player,index_celula)
		player *= -1
		winner = WinConditions.check_win(big_posicoes)
		if winner == 0:
			if !WinConditions.check_draw(big_posicoes):
				ativar_tabuleiro(index_celula)
				player_atual.emit(player)
			else:
				end_game.emit(winner)
		else:
			end_game.emit(winner)

func _on_check_empate():
	var aux = 0
	for tabuleiro in big_posicoes:
		if tabuleiro != 0:
			aux += 1
	if aux == 8:
		winner = 0
		end_game.emit(winner)

func ativar_tabuleiro(index):
	if tabuleiros[index].winner != 0:
		for tabuleiro in tabuleiros:
			if tabuleiro.winner == 0:
				tabuleiro.set_ativo(true)
		return
	for tabuleiro in tabuleiros:
		tabuleiro.set_ativo(false)
	tabuleiros[index].set_ativo(true)

func new_game():
	player = player_inicial*-1
	player_atual.emit(player)
	player_inicial = player
	winner = 0
	big_posicoes = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	for tabuleiro in tabuleiros:
		tabuleiro.new_game()
