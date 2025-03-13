extends Node2D

@export var main_game: PackedScene
@export var new_game_menu_scene: PackedScene

func _ready() -> void:
	_return_main()
	
func _on_new_game_menu_start_game(name1:String, name2:String, game_type:int, dificuldadeIA:int, dificuldadeIA2:int, numPartidas:int = -1) -> void:
	if len(get_children()) > 0:
		get_child(0).queue_free()
	var new_game = main_game.instantiate()
	add_child(new_game)
	new_game.configurar_jogo(name1,name2,game_type,dificuldadeIA,dificuldadeIA2)
	new_game.connect("return_initial", _return_main)
	if numPartidas != -1:
		new_game.max_numero_jogos = numPartidas

func _return_main():
	if len(get_children()) > 0:
		get_child(0).queue_free()
	var new_game_menu = new_game_menu_scene.instantiate()
	add_child(new_game_menu)
	new_game_menu.position = Vector2(0, 0) 
	new_game_menu.connect("start_game",_on_new_game_menu_start_game)
