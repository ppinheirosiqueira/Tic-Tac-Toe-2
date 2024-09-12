extends Node2D

@export var main_game: PackedScene
@onready var new_game_menu: ColorRect = $NewGameMenu

func _on_new_game_menu_start_game(name1:String, name2:String, game_type:int, dificuldadeIA:int, dificuldadeIA2:int) -> void:
	var new_game = main_game.instantiate()
	new_game_menu.queue_free()
	add_child(new_game)
	new_game.configurar_jogo(name1,name2,game_type,dificuldadeIA,dificuldadeIA2)
