extends AudioStreamPlayer

var oldVol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioEffectDelay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if -5 / (Global.userSettings.volume / 100) <= volume_db / (Global.userSettings.musicVol / 100):
	oldVol = -5 + linear_to_db(Global.userSettings.volume / 100)
	#else:
	volume_db = linear_to_db(Global.userSettings.musicVol / 100) + oldVol
	#print(linear_to_db(Global.userSettings.volume / 100))
	#print(volume_db)
	#print_debug(float(-5 / (Global.userSettings.volume / 100)))
	#if Global.userSettings.musicVol <= 10:
		#playing = false
	#elif Global.userSettings.volume <= 10:
		#playing
	#if volume_db <= -47 && playing == true:
		#stream_paused = true
	#elif volume_db >= -46 && playing == false:
		#stream_paused = false
	
