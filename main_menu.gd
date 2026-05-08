extends Control

@export var lobby: LineEdit
@export var username: LineEdit
@export var race: CheckBox

func _ready() -> void:
	connect("settingsClosed", _settingsClosed)
	BackgroundMusic.bus = "menu"
	lobby.text = str(Global.seed)
	username.text = Global.username
	$AnimationPlayer.play_backwards("settingsPressed")

func _on_play_button_down() -> void:
	Global.leavingScene = 'menu'
	$AnimationPlayer.play("sceneTransition")
	await get_tree().create_timer(0.5).timeout
	Network.client.emit('join', [str(Global.seed), race.button_pressed, Global.username])
	#get_tree().change_scene_to_file("res://game.tscn")

func _on_lobby_text_changed(new_text: String) -> void:
	if int(new_text):
		Global.seed = int(new_text)

func _on_username_text_changed(new_text: String) -> void:
	Global.username = new_text
	Global.saveData()

func _on_race_toggled(toggled_on: bool) -> void:
	Global.race = toggled_on

#user settings tab
func _on_settings_pressed() -> void:
	$AnimationPlayer.play("settingsPressed")
	await get_tree().create_timer(0.6).timeout
	$optionsMenu/AnimationPlayer.play("optionsPressed")

func _settingsClosed() -> void:
	$AnimationPlayer.play_backwards("settingsPressed")

func _on_mouse_hover() -> void:
	Sfx.get_node("browseSFX").play()
func _clicksound():
	Sfx.get_node("clickSFX").play()
