extends Area

func _on_Loop_body_entered(body: Node) -> void:
  queue_free()
