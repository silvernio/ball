extends Control

var up1
var up2
var up3

signal lockIn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	up1 = Network.activeModifiers.keys().pick_random()
	up2 = Network.activeModifiers.keys().pick_random()
	while up2 == up1:
		up2 = Network.activeModifiers.keys().pick_random()
	up3 = Network.activeModifiers.keys().pick_random()
	while up3 == up2 or up3 == up1:
		up3 = Network.activeModifiers.keys().pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_upgrade_1_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
func _on_upgrade_2_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
func _on_upgrade_3_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_ready_up_pressed() -> void:
	Global.leavingScene = "upgrade"
	$AnimationPlayer.play("exit")
	await get_tree().create_timer(0.8).timeout
	lockIn.emit()
	
