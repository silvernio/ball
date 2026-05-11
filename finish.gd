extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == 'player':
		Global.running = false
		if Global.race:
			Network.client.emit('finish', Global.time)
			Network._player_finished()
