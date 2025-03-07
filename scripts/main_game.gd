extends Node2D

@onready var tabuleiro_maior: Control = $Fundo/TabuleiroMaior
@onready var info_panel: Control = $Fundo/InfoPanel

var tipo_jogo:int
var IA_1:int
var IA_2:int
var numero_jogos:int = 1
var max_numero_jogos:int = 1

func _ready() -> void:
	info_panel.create_marker_rodada_atual(1)
	tabuleiro_maior.connect("player_atual", _on_change_player_atual)
	tabuleiro_maior.connect("end_game", _on_end_game)
	info_panel.connect("restart", _on_new_game)

func configurar_jogo(name1:String, name2:String, game_type:int, dificuldadeIA:int, dificuldadeIA2:int) -> void:
	info_panel.att_nomes(name1,name2, true if game_type==2 else false)
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

func _on_new_game() -> void:
	numero_jogos += 1
	tabuleiro_maior.new_game()
	if tipo_jogo == 2:
		$IA_Timer.start()
	elif tipo_jogo == 1 and tabuleiro_maior.player == -1:
		$IA_Timer.start()

func _on_ia_timer_timeout() -> void:
	if tipo_jogo == 2 and tabuleiro_maior.player == -1:
		var movimento = IA.IA_step(IA_2, tabuleiro_maior.player, tabuleiro_maior.big_posicoes, tabuleiro_maior.tabuleiros)
		tabuleiro_maior._on_tabuleiro_clicado(movimento[0],movimento[1])
	else:
		var movimento = IA.IA_step(IA_1, tabuleiro_maior.player, tabuleiro_maior.big_posicoes, tabuleiro_maior.tabuleiros)
		tabuleiro_maior._on_tabuleiro_clicado(movimento[0],movimento[1])

func _on_info_panel_check_ia_ia() -> void:
	if tipo_jogo == 2:
		if numero_jogos < max_numero_jogos:
			_on_new_game()
