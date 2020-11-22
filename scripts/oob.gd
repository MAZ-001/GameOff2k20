extends Area


func _on_body_exited(body):
	body.queue_free()
