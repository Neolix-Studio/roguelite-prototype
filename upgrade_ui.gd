extends CanvasLayer

@export var player: Node3D


func _ready() -> void:
	$CenterContainer.hide()
	

func show_passive_choices() -> void:
	$CenterContainer.show()
	get_tree().paused = true


func _on_health_button_pressed() -> void:
	player.increase_max_health(20)
	close_choices()

func _on_speed_button_pressed() -> void:
	player.increase_move_speed(1.0)
	close_choices()

func _on_damage_button_pressed() -> void:
	player.increase_cleave_damage(10)
	close_choices()

func _on_player_passive_choice_requested() -> void:
	show_passive_choices()

func close_choices() -> void:
	$CenterContainer.hide()
	get_tree().paused = false
