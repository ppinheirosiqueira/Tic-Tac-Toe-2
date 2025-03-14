extends Node2D

@export var game_over_scene: PackedScene

@onready var tabuleiro_maior: Control = $Fundo/TabuleiroMaior
@onready var info_panel: CanvasLayer = $Fundo/InfoPanel

signal return_initial

var tipo_jogo:int
var IA_1:int
var IA_2:int
var numero_jogos:int = 1
var max_numero_jogos:int = 1

func _ready() -> void:
	info_panel.create_marker_rodada_atual(1)
	tabuleiro_maior.connect("player_atual", _on_change_player_atual)
	tabuleiro_maior.connect("end_game", _on_end_game)
	
func configurar_jogo(name1:String, name2:String, game_type:int, dificuldadeIA:int, dificuldadeIA2:int) -> void:
	info_panel.att_nomes(name1,name2)
	tipo_jogo = game_type
	IA_1 = dificuldadeIA
	IA_2 = dificuldadeIA2
	if tipo_jogo == 2:
		$IA_Timer.start()

func _on_change_player_atual(player:int) -> void:
	info_panel.create_marker_rodada_atual(player)
	if tipo_jogo == 2 or (tipo_jogo == 1 and player == -1):
		$IA_Timer.start()

func _on_end_game(winner:int) -> void:
	info_panel.att_vitorias(winner)
	if tipo_jogo == 2 and numero_jogos < max_numero_jogos:
		_on_new_game()
	else:
		var game_over = game_over_scene.instantiate()
		game_over.connect("restart",_on_game_over_menu_restart)
		game_over.connect("return_initial", _on_game_over_return)
		add_child(game_over)
		game_over.att_label(winner, info_panel.nome_player1 if winner == 1 else info_panel.nome_player2,tipo_jogo,info_panel.vitorias)
		get_tree().paused = true
		
func _on_new_game() -> void:
	numero_jogos += 1
	tabuleiro_maior.new_game()
	if tipo_jogo == 2 or (tipo_jogo == 1 and tabuleiro_maior.player == -1):
		$IA_Timer.start()

func _on_ia_timer_timeout() -> void:
	var tempo_inicial = Time.get_ticks_msec()
	var movimento
	if tipo_jogo == 2 and tabuleiro_maior.player == -1:
		movimento = IA.IA_step(IA_2, tabuleiro_maior.player, tabuleiro_maior.big_posicoes, tabuleiro_maior.tabuleiros)
	else:
		movimento = IA.IA_step(IA_1, tabuleiro_maior.player, tabuleiro_maior.big_posicoes, tabuleiro_maior.tabuleiros)
	var tempo_final = Time.get_ticks_msec()
	if tempo_final - tempo_inicial < 1000:
		await get_tree().create_timer((1000 - tempo_final) / 1000.0).timeout
	tabuleiro_maior._on_tabuleiro_clicado(movimento[0],movimento[1])

func _on_game_over_menu_restart() -> void:
	get_tree().paused = false
	if tipo_jogo == 2:
		numero_jogos = 0
	_on_new_game()

func _on_game_over_return() -> void:
	get_tree().paused = false
	return_initial.emit()

func _on_info_panel_return_initial() -> void:
	return_initial.emit()
