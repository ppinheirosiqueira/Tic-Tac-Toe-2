extends Resource
class_name SaveGame

const SAVE_PATH_GAME := "user://data.tres"

@export var vitorias:Dictionary[String, Dictionary]
@export var choose_marker:int
@export var prefered_language:String

func _init() -> void:
	choose_marker = Preferencias.choose_marker
	prefered_language = Preferencias.prefered_language
	vitorias = Preferencias.vitorias
	
func save_game() -> void:
	ResourceSaver.save(self,SAVE_PATH_GAME)
	
static func load_game() -> SaveGame:
	if ResourceLoader.exists(SAVE_PATH_GAME):
		return load(SAVE_PATH_GAME)
	return null
