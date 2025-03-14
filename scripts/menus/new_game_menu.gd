extends ColorRect

@export var regras_scene: PackedScene
@export var partida_local_scene: PackedScene
@export var partida_ia_scene: PackedScene
@export var partida_ia_ia_scene: PackedScene

@onready var titulo: Label = %Titulo
@onready var partida_local: Button = %PartidaLocal
@onready var partida_ia: Button = %PartidaIA
@onready var partida_ia_2: Button = %PartidaIA2
@onready var regras_button: Button = %RegrasButton
@onready var option_button: OptionButton = %OptionButton
@onready var label_marker_choose: Label = %LabelMarkerChoose
@onready var texture_button: TextureButton = %TextureButton

signal start_game

var idiomas = {
	"EN": "en_US",
	"PT": "pt_BR",
}

func _ready() -> void:
	if Preferencias.choose_marker == -1:
		texture_button.button_pressed = true
	option_button.connect("item_selected", _on_idioma_selecionado)
	_on_idioma_selecionado(0)
	
func _on_idioma_selecionado(index):
	var idioma_escolhido = option_button.get_item_text(index)
	TranslationServer.set_locale(idiomas[idioma_escolhido])
	update_language()

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

func update_language() -> void:
	titulo.text = tr("TITLE")
	partida_local.text = tr("LOCAL")
	partida_ia.text = tr("IA")
	partida_ia_2.text = tr("IAxIA")
	regras_button.text = tr("RULES")
	label_marker_choose.text = tr("MARKER_CHOOSE")

func _on_texture_button_toggled(toggled_on: bool) -> void:
	Preferencias.choose_marker = -1 if toggled_on else 1
