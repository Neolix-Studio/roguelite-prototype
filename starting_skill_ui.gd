extends CanvasLayer

@export var player: Node3D


func _ready() -> void:
	get_tree().paused = true
	
func finish_selection() -> void:
	$CenterContainer.hide()
	get_tree().paused = false

func _on_cleave_button_pressed() -> void:
	player.active_skill("Cleave")
	finish_selection()


func _on_fireball_button_pressed() -> void:
	player.active_skill("Fireball")
	finish_selection()

func _on_curse_button_pressed() -> void:
	player.active_skill("Curse")
	finish_selection()

func show_skill_choices() -> void:
	$CenterContainer/PanelContainer/VBoxContainer/TitleLabel.text = "Choose or Upgrade a Skill"
	$CenterContainer.show()
	get_tree().paused = true


func _on_player_skill_choice_requested() -> void:
	show_skill_choices()
