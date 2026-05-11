extends Control

var players = []
var mapLength = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("animation_fix")
	_optionsChanged()
	Network.on_player_joined.connect(_addPlayer)
	Network.on_player_left.connect(_removePlayer)
	Network.options_changed.connect(_optionsChanged)
	#Network.on_player_left.connect(_removePlayer)
	$hostName.text = Network.names[Network.names.keys()[0]] + "'s lobby"
	players = Network.names.values()
	for username in players:
		$playerList.add_item(username)
		
	Network.emit('getOptions')

func animation_fix():
	#print($AnimationPlayer.get_animation_list())
	if Global.leavingScene == 'menu':
		$AnimationPlayer.play("sceneOut")
	elif Global.leavingScene == 'game':
		$AnimationPlayer.play("leftGame")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _addPlayer(_id, username):
	$playerList.add_item(username)

func _removePlayer(id):
	$playerList.remove_item(Network.names.keys().find(id))
	if Network.names.keys().find(id) == 0:
		$hostName.text = Network.names[Network.names.keys()[1]] + "'s lobby"

func _on_start_button_down() -> void:
	$AnimationPlayer.play("goToGame")
	await get_tree().create_timer(0.5).timeout
	Network.client.emit('start')
	

#sync settings
func _optionsChanged():
	#track settings
	$track/seed/seed.value = Network.options.seed
	$track/seed/randomise.button_pressed = Network.options.randomiseSeed
	$track/randomise.button_pressed = Network.options.randomiseSettings
	$track/length/lengthBox.value = Network.options.length
	$track/length/lengthVal.value = Network.options.length
	$track/turning/turningBox.value = Network.options.turning
	$track/turning/turningVal.value = Network.options.turning
	$track/size/sizeBox.value = Network.options.trackSize
	$track/size/sizeVal.value = Network.options.trackSize
	$track/globalChance/globlValLabel.text = "1 in " + str(int(Network.options.globalModChance))
	if $track/globalChance/globalVal.value == 1:
		$track/globalChance/globlValLabel.text = "always"
	elif $track/globalChance/globalVal.value == 0:
		$track/globalChance/globlValLabel.text = "never"
	$track/globalChance/globalVal.value = Network.options.globalModChance
	
	#player settings
	$player/jumps/jumpBox.button_pressed = Network.options.jumps
	$player/speed/speedVal.value = Network.options.speed
	$player/speed/speedBox.value = Network.options.speed

#Map length change
func _on_length_val_value_changed(value: float) -> void:
	$track/length/lengthBox.value = $track/length/lengthVal.value
	Network.options.length = $track/length/lengthBox.value

func _on_length_box_value_changed(value: float) -> void:
	$track/length/lengthVal.value = $track/length/lengthBox.value
	Network.options.length = $track/length/lengthBox.value

#turning amount change
func _on_turning_val_value_changed(value: float) -> void:
	$track/turning/turningBox.value = $track/turning/turningVal.value
	Network.options.turning = $track/turning/turningBox.value

func _on_turning_box_value_changed(value: float) -> void:
	$track/turning/turningVal.value = $track/turning/turningBox.value
	Network.options.turning = $track/turning/turningBox.value

#track size change
func _on_size_val_value_changed(value: float) -> void:
	$track/size/sizeBox.value = $track/size/sizeVal.value
	Network.options.trackSize = $track/size/sizeBox.value

func _on_size_box_value_changed(value: float) -> void:
	$track/size/sizeVal.value = $track/size/sizeBox.value
	Network.options.trackSize = $track/size/sizeBox.value

#jumping
func _on_jump_box_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$player/jumps/jumpLabel2.text = "Enabled"
	else:
		$player/jumps/jumpLabel2.text = "Disabled"
	Network.options.jumps = toggled_on

#player speed
func _on_speed_val_value_changed(value: float) -> void:
	$player/speed/speedBox.value = $player/speed/speedVal.value
	Network.options.speed = $player/speed/speedBox.value

func _on_speed_box_value_changed(value: float) -> void:
	$player/speed/speedVal.value = $player/speed/speedBox.value
	Network.options.speed = $player/speed/speedBox.value

func _on_exit_button_pressed() -> void:
	$AnimationPlayer.play_backwards("sceneOut")
	Global.leavingScene = 'lobby'
	Network.emit ('leave')

func _on_seed_value_changed(value: float) -> void:
	Network.options.seed = value

func _on_randomise_toggled(toggled_on: bool) -> void:
	Network.options.randomiseSeed = toggled_on

func _on_mouse_hover() -> void:
	Sfx.get_node("browseSFX").play()
func _clicksound():
	Sfx.get_node("clickSFX").play()

func _on_global_val_value_changed(value: float) -> void:
	$track/globalChance/globlValLabel.text = "1 in " + str(int($track/globalChance/globalVal.value))
	if $track/globalChance/globalVal.value == 1:
		$track/globalChance/globlValLabel.text = "always"
	elif $track/globalChance/globalVal.value == 0:
		$track/globalChance/globlValLabel.text = "never"
	Network.options.globalModChance = int($track/globalChance/globalVal.value)

func _on_randomise_settings_toggled(toggled_on: bool) -> void:
	Network.options.randomiseSettings = toggled_on
