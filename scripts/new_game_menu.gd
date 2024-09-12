extends ColorRect

var dificuldade:int = 0
var dificuldade2:int = 0
var name1: String
var name2: String

signal start_game

func _on_partida_local_pressed() -> void:
	hide_panels()
	$PartidaLocalMenu.show()
	name1 = ""
	name2 = ""
	
func _on_partida_ia_pressed() -> void:
	hide_panels()
	$PartidaIAMenu.show()
	name1 = ""
	name2 = "IA Fácil"
	
func _on_partida_ia_2_pressed() -> void:
	hide_panels()
	$PartidaIA2Menu.show()
	name1 = "IA 1 - Fácil"
	name2 = "IA 2 - Fácil"

func hide_panels() -> void:
	$PartidaLocalMenu.hide()
	$PartidaIAMenu.hide()
	$PartidaIA2Menu.hide()

func _on_name_player_text_changed(new_text: String) -> void:
	name1 = new_text

func _on_name_player_2_text_changed(new_text: String) -> void:
	name2 = new_text

func _on_name_player_ia_text_changed(new_text: String) -> void:
	name1 = new_text

func _on_ia_solo_0_pressed() -> void:
	dificuldade = -1
	name2 = "IA Aleatória"

func _on_ia_solo_1_pressed() -> void:
	dificuldade = 0
	name2 = "IA Fácil"

func _on_ia_solo_2_pressed() -> void:
	dificuldade = 1
	name2 = "IA Média"

func _on_ia_solo_3_pressed() -> void:
	dificuldade = 2
	name2 = "IA Difícil"

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

func _on_start_game_local_pressed() -> void:
	start_game.emit(name1 if name1 else "Player 1",name2 if name2 else "Player 2",0,0,0)

func _on_start_game_ia_pressed() -> void:
	start_game.emit(name1 if name1 else "Player 1",name2,1,dificuldade,0)

func _on_start_game_ia_ia_pressed() -> void:
	start_game.emit(name1,name2,2,dificuldade,dificuldade2)
