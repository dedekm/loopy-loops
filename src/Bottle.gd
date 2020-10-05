extends Spatial

func _ready() -> void:
  $FireworksParticles.emitting = true

func _on_Area_body_entered(body: Node) -> void:
  $Cylinder.queue_free()
  $Area.queue_free()
  $Spill.visible = true
  $SpillParticles.visible = true
  $SpillParticles.emitting = true
  $AudioStreamPlayer.play()
  body.open_mouth()
  
