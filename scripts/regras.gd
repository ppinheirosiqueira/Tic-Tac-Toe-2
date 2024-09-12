extends Window

func _on_close_requested() -> void:
	get_tree().paused = false
	queue_free()
