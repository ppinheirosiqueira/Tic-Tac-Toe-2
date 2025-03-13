extends CanvasLayer

signal restart
signal return_initial

@onready var restart_button: Button = %Restart
@onready var return_button: Button = %Return
@onready var win_label: Label = %WinLabel

func _ready() -> void:
	restart_button.text = tr("NEW_GAME_BUTTON")
	return_button.text = tr("INITIAL_PAGE_BUTTON")

func _on_restart_pressed():
	restart.emit()
	queue_free()

func att_label(vencedor:int, nome:String, tipo_jogo:int, vitorias:Array[int]):
	if tipo_jogo != 2:
		if vencedor == 0:
			win_label.text = tr("DRAW")
		else:
			win_label.text = tr("WINNER") % nome
	else:
		win_label.text = tr("FINAL_IA_MATCH") % [vitorias[0], vitorias[1], vitorias[2]]

func _on_return_pressed() -> void:
	return_initial.emit()
	queue_free()
