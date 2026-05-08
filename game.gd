extends Node3D

@export var player: Player
@export var camera: Camera
@export var start: Label

func _ready() -> void:
	Network.newRace.connect(_global_modifier)
	Network.spawn.connect(_on_spawn)
	BackgroundMusic.bus = "inGame"
	connect("settingsClosed", _settingsClosed)
	Global.running = not Global.race
	Global.isReady = false

func _on_spawn(_index):
	if $CanvasLayer/Control/AnimationPlayer.current_animation == "globalModDetected":
		$CanvasLayer/Control/AnimationPlayer.seek(0, true)
	$CanvasLayer/Control/AnimationPlayer.play("startTimer")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('ready'):
		$CanvasLayer/Control/optionsMenu.visible = false
		if Global.race:
			if not Global.running:
				Global.isReady = not Global.isReady
		elif not Global.running:
			Global.running = true
			Global.time = 0
			player.reset()
	
	var unix_timestamp_ms = Network.get_time()
	if unix_timestamp_ms < Global.startTime:
		start.text = str(int(min(3, ceil((Global.startTime - unix_timestamp_ms) / 1000))))
	#else:
		#start.text = ''
	
	if Global.startTime != -1 and unix_timestamp_ms >= Global.startTime:
		await get_tree().create_timer(1).timeout
		Global.startTime = -1
		Global.time = 0
		Global.running = true
		Global.isReady = false
	
	if Input.is_action_just_pressed("esc"):
		if BackgroundMusic.bus == "inGame":
			BackgroundMusic.bus = "pause"
		elif BackgroundMusic.bus == "pause":
			BackgroundMusic.bus = "inGame"
		$CanvasLayer/Control/pauseMenu.visible = !$CanvasLayer/Control/pauseMenu.visible
	
	$CanvasLayer/Control/loading/name.text = Global.progressName
	Global.progress = $track.progress
	if $track.progress != -1:
		$CanvasLayer/Control/loading.visible = true
		$CanvasLayer/Control/loading/progress.value = $track.progress * 100
	else:
		$CanvasLayer/Control/loading.visible = false

func _global_modifier():
	if Network.globalMod != null:
		$CanvasLayer/Control/AnimationPlayer.play("globalModDetected")

func _on_settings_button_pressed() -> void:
	Sfx.get_node("clickSFX").play()
	$CanvasLayer/Control/pauseMenu.visible = !$CanvasLayer/Control/pauseMenu.visible
	$CanvasLayer/Control/optionsMenu.visible = true
	$CanvasLayer/Control/optionsMenu/AnimationPlayer.play("optionsPressed")

func _on_lobby_button_pressed() -> void:
	Global.leavingScene = 'game'
	BackgroundMusic.bus = "menu"
	Sfx.get_node("clickSFX").play()
	Global.scene = 'lobby'
	$CanvasLayer/Control/AnimationPlayer.play("leave game")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://lobby_menu.tscn")

func _on_close_button_pressed() -> void:
	BackgroundMusic.bus = "inGame"
	$CanvasLayer/Control/pauseMenu.visible = false
	Sfx.get_node("clickSFX").play()

func _settingsClosed():
	$CanvasLayer/Control/pauseMenu.visible = true

func _on_mouse_hover() -> void:
	Sfx.get_node("browseSFX").play()
func _clicksound():
	Sfx.get_node("clickSFX").play()
