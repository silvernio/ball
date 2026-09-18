extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioEffectDelay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if -5 / (Global.userSettings.volume / 100) <= volume_db / (Global.userSettings.musicVol / 100):
	volume_db = -5 / (Global.userSettings.volume)
	#else:
	volume_db = volume_db / (Global.userSettings.musicVol)
	#print(float(-5 / (Global.userSettings.volume / 100)))
	#if Global.userSettings.musicVol <= 10:
		#playing = false
	#elif Global.userSettings.volume <= 10:
		#playing
	#if volume_db <= -47 && playing == true:
		#stream_paused = true
	#elif volume_db >= -46 && playing == false:
		#stream_paused = false
	
