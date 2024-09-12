extends Panel

@export var game_over_scene: PackedScene
@export var regras_scene: PackedScene

@export var circle_scene: PackedScene
@export var cross_scene: PackedScene
@onready var player_atual = %PlayerAtual

var vitorias: Array = [0, 0, 0]
var nome_player1: String
var nome_player2: String
var shift_player_atual: Vector2

signal restart

func _ready() -> void:
	shift_player_atual = player_atual.get_rect().size/2

func _on_button_pressed():
	var regra = regras_scene.instantiate()
	add_child(regra)
	get_tree().paused = true

func att_nomes(nome1: String, nome2:String) -> void:
	nome_player1 = nome1
	nome_player2 = nome2
	%Player1Label.text = "[center]Vit. %s [color=green]O[/color]:[/center]" % nome1
	%Player2Label.text = "[center]Vit. %s [color=red]X[/color]:[/center]" % nome2

func att_vitorias(vencedor:int) -> void:
	var game_over = game_over_scene.instantiate()
	if vencedor == 1:
		game_over.att_label(vencedor, nome_player1)
		vitorias[0] = vitorias[0] + 1
		%Player1ScoreLabel.text = str(vitorias[0])
	elif vencedor == -1:
		game_over.att_label(vencedor, nome_player2)
		vitorias[1] = vitorias[1] + 1
		%Player2ScoreLabel.text = str(vitorias[1])
	else:
		game_over.att_label(vencedor, "")
		vitorias[2] = vitorias[2] + 1
		%DrawScoreLabel.text = str(vitorias[2])
	game_over.connect("restart",_on_game_over_menu_restart)
	add_child(game_over)
	get_tree().paused = true

func _on_game_over_menu_restart():
	restart.emit()
	get_tree().paused = false
	
func create_marker_rodada_atual(player:int):
	for child in player_atual.get_children():
		child.queue_free()
	var new_mark
	if player == 1:
		new_mark = circle_scene.instantiate()
	else:
		new_mark = cross_scene.instantiate()
	new_mark.scale = Vector2(1.75, 1.75)
	new_mark.position += shift_player_atual
	player_atual.add_child(new_mark)
