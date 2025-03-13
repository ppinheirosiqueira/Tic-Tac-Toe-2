extends Window

var dificuldade:int = 0
var dificuldade2:int = 0
var name1: String = "IA 1 - Fácil"
var name2: String = "IA 2 - Fácil"
var numPartidas: int = 10

signal start_game

@onready var labelNumPartidas = %LabelNumPartidas

func _on_close_requested() -> void:
	queue_free()

func _on_ia_0_pressed() -> void:
	dificuldade = -1
	name1 = "IA 1 - Aleatória"

func _on_ia_1_pressed() -> void:
	dificuldade = 0
	name1 = "IA 1 - Fácil"

func _on_ia_2_pressed() -> void:
	dificuldade = 1
	name1 = "IA 1 - Média"

func _on_ia_3_pressed() -> void:
	dificuldade = 3
	name1 = "IA 1 - Difícil"

func _on_ia_2_0_pressed() -> void:
	dificuldade2 = -1
	name2 = "IA 2 - Aleatória"

func _on_ia_2_1_pressed() -> void:
	dificuldade2 = 0
	name2 = "IA 2 - Fácil"

func _on_ia_2_2_pressed() -> void:
	dificuldade2 = 1
	name2 = "IA 2 - Média"

func _on_ia_2_3_pressed() -> void:
	dificuldade2 = 3
	name2 = "IA 2 - Difícil"

func _on_start_game_ia_ia_pressed() -> void:
	numPartidas = int(%LabelNumPartidas.text)
	start_game.emit(name1,name2,2,dificuldade,dificuldade2,numPartidas)

func _on_label_num_partidas_text_changed(new_text: String) -> void:
	var filtered_text = ""
	for letra in new_text:
		if letra.is_valid_int():
			filtered_text += letra
	labelNumPartidas.text = filtered_text
