extends Node

var sfxVol = AudioServer.get_bus_index("clicks")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$clickSFX.volume_db = -1 / (Global.userSettings.volume / 100)
	#$browseSFX.volume_db = -1 / (Global.userSettings.volume / 100)
	#print($browseSFX.volume_db)
	AudioServer.set_bus_volume_db(4, -5/(Global.userSettings.sfxVol / 100))
	#sfxVol. = 0 / (Global.userSettings.sfxVol / 100)
