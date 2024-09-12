extends Panel

var dificuldade:int = 0
var dificuldade2:int = 0
var name1: String = "IA Fácil"
var name2: String = "IA Fácil"

signal start_game()

func _on_local_game_pressed() -> void:
	hide_panels()
	$panel_Local.show()

func _on_ia_game_pressed() -> void:
	hide_panels()
	$panel_IA.show()

func _on_i_ax_ia_game_pressed() -> void:
	hide_panels()
	$panel_IAxIA.show()

func _on_check_button_pressed() -> void:
	dificuldade = -1
	name2 = "Aleatório"

func _on_check_button_2_pressed() -> void:
	dificuldade = 0
	name2 = "IA Fácil"

func _on_check_button_3_pressed() -> void:
	dificuldade = 1
	name2 = "IA Média"

func _on_check_button_4_pressed() -> void:
	dificuldade = 2
	name2 = "IA Difícil"

func _on_name_player_text_changed(new_text) -> void:
	name1 = new_text

func _on_name_player_2_text_changed(new_text) -> void:
	name2 = new_text

func hide_panels() -> void:
	$panel_Local.hide()
	$panel_IA.hide()
	$panel_IAxIA.hide()

func _on_close_button_pressed() -> void:
	$panel_IA.hide()

func _on_close_button_2_pressed() -> void:
	$panel_Local.hide()
	
func _on_close_button_3_pressed() -> void:
	$panel_IAxIA.hide()

func _on_ia_1_1_pressed() -> void:
	dificuldade = -1
	name1 = "Aleatório"

func _on_ia_1_2_pressed() -> void:
	dificuldade = 0
	name1 = "IA Fácil"

func _on_ia_1_3_pressed() -> void:
	dificuldade = 1
	name1 = "IA Média"

func _on_ia_1_4_pressed() -> void:
	dificuldade = 2
	name1 = "IA Difícil"

func _on_ia_2_1_pressed() -> void:
	dificuldade2 = -1
	name2 = "Aleatório"

func _on_ia_2_2_pressed() -> void:
	dificuldade2 = 0
	name2 = "IA Fácil"

func _on_ia_2_3_pressed() -> void:
	dificuldade2 = 1
	name2 = "IA Média"

func _on_ia_2_4_pressed() -> void:
	dificuldade2 = 2
	name2 = "IA Difícil"

func _on_start_game_local_pressed() -> void:
	start_game.emit(name1,name2,0,0,0)

func _on_start_game_ia_pressed() -> void:
	start_game.emit(name1,name2,1,dificuldade,0)

func _on_start_game_i_ax_ia_pressed() -> void:
	start_game.emit(name1,name2,2,dificuldade,dificuldade2)
