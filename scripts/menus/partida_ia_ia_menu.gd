extends Window

var dificuldade:int = 0
var dificuldade2:int = 0
var name1: String
var name2: String
var numPartidas: int = 10

signal start_game

@onready var labelNumPartidas = %LabelNumPartidas

func _ready() -> void:
	%Label.text = tr("CHOOSE_IA_DIFFICULT_1")
	%IA_0.text = tr("RANDOM_IA")
	%IA_1.text = tr("EASY_IA")
	%IA_2.text = tr("MEDIUM_IA")
	%IA_3.text = tr("HARD_IA")
	%Label2.text = tr("CHOOSE_IA_DIFFICULT_2")
	%IA2_0.text = tr("RANDOM_IA")
	%IA2_1.text = tr("EASY_IA")
	%IA2_2.text = tr("MEDIUM_IA")
	%IA2_3.text = tr("HARD_IA")
	%LabelNumPartidas2.text = tr("NUM_OF_MATCHES")
	%StartGameIaIa.text = tr("START_GAME_BUTTON")

func _on_close_requested() -> void:
	queue_free()

func _on_ia_0_pressed() -> void:
	dificuldade = -1
	name1 = tr("RANDOM_IA")

func _on_ia_1_pressed() -> void:
	dificuldade = 0
	name1 = tr("EASY_IA")

func _on_ia_2_pressed() -> void:
	dificuldade = 1
	name1 = tr("MEDIUM_IA")

func _on_ia_3_pressed() -> void:
	dificuldade = 3
	name1 = tr("HARD_IA")

func _on_ia_2_0_pressed() -> void:
	dificuldade2 = -1
	name2 = tr("RANDOM_IA")

func _on_ia_2_1_pressed() -> void:
	dificuldade2 = 0
	name2 = tr("EASY_IA")

func _on_ia_2_2_pressed() -> void:
	dificuldade2 = 1
	name2 = tr("MEDIUM_IA")

func _on_ia_2_3_pressed() -> void:
	dificuldade2 = 3
	name2 = tr("HARD_IA")

func _on_start_game_ia_ia_pressed() -> void:
	numPartidas = int(%LabelNumPartidas.text)
	start_game.emit(name1 if name1 else tr("EASY_IA"),name2 if name2 else tr("EASY_IA"),2,dificuldade,dificuldade2,numPartidas)

func _on_label_num_partidas_text_changed(new_text: String) -> void:
	var filtered_text = ""
	for letra in new_text:
		if letra.is_valid_int():
			filtered_text += letra
	labelNumPartidas.text = filtered_text
