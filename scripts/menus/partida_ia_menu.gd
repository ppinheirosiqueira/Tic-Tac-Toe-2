extends Window

var name1: String
var name2: String
var dificuldade:int = 0

signal start_game

func _on_close_requested() -> void:
	queue_free()

func _on_start_game_ia_pressed() -> void:
	start_game.emit(name1 if name1 else "Player 1",name2,1,dificuldade,0)
	
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
	
