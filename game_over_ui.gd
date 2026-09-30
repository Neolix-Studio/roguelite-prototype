extends CanvasLayer

func _ready() -> void:
	$CenterContainer.hide()

func _on_player_died() -> void:
	$CenterContainer.show()
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
