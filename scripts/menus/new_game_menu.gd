extends ColorRect

@export var regras_scene: PackedScene
@export var partida_local_scene: PackedScene
@export var partida_ia_scene: PackedScene
@export var partida_ia_ia_scene: PackedScene

signal start_game

func _on_partida_local_pressed() -> void:
	var cena = partida_local_scene.instantiate()
	add_child(cena)
	cena.start_game.connect(_on_child_start_game)
	
func _on_partida_ia_pressed() -> void:
	var cena = partida_ia_scene.instantiate()
	add_child(cena)
	cena.start_game.connect(_on_child_start_game)
	
func _on_partida_ia_2_pressed() -> void:
	var cena = partida_ia_ia_scene.instantiate()
	add_child(cena)
	cena.start_game.connect(_on_child_start_game)

func _on_regras_button_pressed() -> void:
	var regra = regras_scene.instantiate()
	add_child(regra)
	get_tree().paused = true

func _on_child_start_game(var1, var2, var3, var4, var5, var6 = 0) -> void:
	start_game.emit(var1, var2, var3, var4, var5, var6)
