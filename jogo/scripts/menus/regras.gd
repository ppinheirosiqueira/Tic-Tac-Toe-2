extends Window

func _ready() -> void:
	%RichTextLabel.text = tr("RULES_TEXT")
	title = tr("RULES")

func _on_close_requested() -> void:
	get_tree().paused = false
	queue_free()
