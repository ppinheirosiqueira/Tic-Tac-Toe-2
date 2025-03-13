extends Window

var name1: String
var name2: String 
var dificuldade:int = 0

signal start_game

func _ready() -> void:
	%LabelPlayer.text = tr("NAME_PLAYER")
	%LabelIA.text = tr("CHOOSE_IA_DIFFICULT")
	%IaSolo_0.text = tr("RANDOM_IA")
	%IaSolo_1.text = tr("EASY_IA")
	%IaSolo_2.text = tr("MEDIUM_IA")
	%IaSolo_3.text = tr("HARD_IA")
	
func _on_close_requested() -> void:
	queue_free()

func _on_start_game_ia_pressed() -> void:
	start_game.emit(name1 if name1 else tr("PLAYER_1"),name2 if name2 else tr("EASY_IA"),1,dificuldade,0)
	
func _on_name_player_ia_text_changed(new_text: String) -> void:
	name1 = new_text

func _on_ia_solo_0_pressed() -> void:
	dificuldade = -1
	name2 = tr("RANDOM_IA")
	
func _on_ia_solo_1_pressed() -> void:
	dificuldade = 0
	name2 = tr("EASY_IA")
	
func _on_ia_solo_2_pressed() -> void:
	dificuldade = 1
	name2 = tr("MEDIUM_IA")
	
func _on_ia_solo_3_pressed() -> void:
	dificuldade = 2
	name2 = tr("HARD_IA")
	
