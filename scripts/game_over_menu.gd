extends CanvasLayer

signal restart

func _on_restart_pressed():
	restart.emit()
	queue_free()

func att_label(vencedor:int, nome:String):
	if vencedor == 0:
		$WinLabel.text = "Empate"
	else:
		$WinLabel.text = "%s venceu" % nome
	
