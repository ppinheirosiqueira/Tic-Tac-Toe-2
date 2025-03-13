extends Control

@export var game_over_scene: PackedScene
@export var regras_scene: PackedScene
@export var circle_scene: PackedScene
@export var cross_scene: PackedScene

@onready var panel_player_atual: Panel = %PanelPlayerAtual

var ia_ia:bool

signal restart
signal check_ia_ia

var vitorias: Array = [0, 0, 0]
var nome_player1: String
var nome_player2: String
var shift_player_atual: Vector2

func att_nomes(nome1: String, nome2:String, tipo:bool) -> void:
	ia_ia = tipo
	nome_player1 = nome1
	nome_player2 = nome2
	%Player1Name.text = "[center]%s [color=green]O[/color]:[/center]" % nome1
	%Player2Name.text = "[center]%s [color=red]X[/color]:[/center]" % nome2

func create_marker_rodada_atual(player:int) -> void:
	for child in panel_player_atual.get_children():
		child.queue_free()
	var new_mark
	if player == 1:
		new_mark = circle_scene.instantiate()
	else:
		new_mark = cross_scene.instantiate()
	new_mark.scale = Vector2(1.5, 1.5)
	new_mark.position += shift_player_atual
	panel_player_atual.add_child(new_mark)

func att_vitorias(vencedor:int) -> void:
	var game_over = game_over_scene.instantiate()
	if vencedor == 1:
		game_over.att_label(vencedor, nome_player1)
		vitorias[0] += 1
		%Player1ScoreLabel.text = str(vitorias[0])
	elif vencedor == -1:
		game_over.att_label(vencedor, nome_player2)
		vitorias[1] += 1
		%Player2ScoreLabel.text = str(vitorias[1])
	else:
		game_over.att_label(vencedor, "")
		vitorias[2] += 1
		%EmpateScoreLabel.text = str(vitorias[2])
	game_over.connect("restart",_on_game_over_menu_restart)
	if ia_ia:
		check_ia_ia.emit()
	else:
		add_child(game_over)
		get_tree().paused = true

func _on_game_over_menu_restart() -> void:
	restart.emit()
	get_tree().paused = false

func _on_regras_button_pressed() -> void:
	var regra = regras_scene.instantiate()
	add_child(regra)
	get_tree().paused = true
