extends CanvasLayer

@export var regras_scene: PackedScene

@onready var panel_player_atual: Panel = %PanelPlayerAtual

var vitorias: Array[int] = [0, 0, 0]
var nome_player1: String
var nome_player2: String

signal return_initial

func _ready() -> void:
	%RegrasButton.text = tr("RULES")
	%ReturnButton.text = tr("INITIAL_PAGE_BUTTON")
	%PlayerAtual.text = tr("JOGADOR_ATUAL")
	%Empate.text = tr("DRAWS")

func att_nomes(nome1: String, nome2:String) -> void:
	nome_player1 = nome1
	nome_player2 = nome2
	if Preferencias.choose_marker == 1:
		%Player1Name.text = "[center]%s [color=green]O[/color]:[/center]" % nome1
		%Player2Name.text = "[center]%s [color=red]X[/color]:[/center]" % nome2
	else:
		%Player1Name.text = "[center]%s [color=red]X[/color]:[/center]" % nome1
		%Player2Name.text = "[center]%s [color=green]O[/color]:[/center]" % nome2
		
func create_marker_rodada_atual(player:int) -> void:
	for child in panel_player_atual.get_children():
		child.queue_free()
	var new_mark
	if player == 1:
		new_mark = Preferencias.cenas[Preferencias.choose_marker].instantiate()
	else:
		new_mark = Preferencias.cenas[-Preferencias.choose_marker].instantiate()
	new_mark.scale = Vector2(1.5, 1.5)
	panel_player_atual.add_child(new_mark)

func att_vitorias(vencedor:int) -> void:
	if vencedor == 1:
		vitorias[0] += 1
		%Player1ScoreLabel.text = str(vitorias[0])
	elif vencedor == -1:
		vitorias[1] += 1
		%Player2ScoreLabel.text = str(vitorias[1])
	else:
		vitorias[2] += 1
		%EmpateScoreLabel.text = str(vitorias[2])

func _on_regras_button_pressed() -> void:
	var regra = regras_scene.instantiate()
	add_child(regra)
	get_tree().paused = true

func _on_return_button_pressed() -> void:
	return_initial.emit()
