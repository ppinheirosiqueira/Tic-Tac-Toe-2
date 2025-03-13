extends Window

var name1: String
var name2: String

signal start_game

func _ready() -> void:
	%Label.text = tr("NAME_1_PLAYER")
	%Label2.text = tr("NAME_2_PLAYER")
	%StartGameLocal.text = tr("START_GAME_BUTTON")
	
func _on_close_requested() -> void:
	queue_free()

func _on_start_game_local_pressed() -> void:
	start_game.emit(name1 if name1 else tr("PLAYER_1"),name2 if name2 else tr("PLAYER_2"),0,0,0)

func _on_name_player_text_changed(new_text: String) -> void:
	name1 = new_text

func _on_name_player_2_text_changed(new_text: String) -> void:
	name2 = new_text
