extends Control

signal settingsClosed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$volBox.value = Global.userSettings.volume
	$volSlider.value = Global.userSettings.volume
	$volBoxMusic.value = Global.userSettings.musicVol
	$volSliderMusic.value = Global.userSettings.musicVol

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	print(Global.leavingScene)
	$AnimationPlayer.play_backwards("optionsPressed")
	await get_tree().create_timer(0.425).timeout
	emit_signal("settingsClosed")

func _on_vol_slider_value_changed(value: float) -> void:
	$volBox.value = $volSlider.value
	Global.userSettings.volume = $volBox.value
	Global.saveData()
	
func _on_vol_box_value_changed(value: float) -> void:
	$volSlider.value = $volBox.value
	Global.userSettings.volume = $volBox.value
	Global.saveData()
func _on_vol_slider_music_value_changed(value: float) -> void:
	$volBoxMusic.value = $volSliderMusic.value
	Global.userSettings.musicVol = $volBoxMusic.value
	Global.saveData()
	
func _on_vol_box_music_value_changed(value: float) -> void:
	$volSliderMusic.value = $volBoxMusic.value
	Global.userSettings.musicVol = $volBoxMusic.value
	Global.saveData()
	
func _on_sfx_slider_value_changed(value: float) -> void:
	$sfxBox.value = $sfxSlider.value
	Global.userSettings.sfxVol = $sfxBox.value
	Global.saveData()
func _on_sfx_box_value_changed(value: float) -> void:
	$sfxSlider.value = $sfxBox.value
	Global.userSettings.sfxVol = $sfxBox.value
	Global.saveData()


#func _on_in_game_back_pressed() -> void:
	#BackgroundMusic.bus = "inGame"
	#$AnimationPlayer.play_backwards("inGameOptions")
	#await get_tree().create_timer(0.425).timeout
	#emit_signal("settingsClosed")

func _on_mouse_hover() -> void:
	Sfx.get_node("browseSFX").play()
func _clicksound():
	Sfx.get_node("clickSFX").play()
