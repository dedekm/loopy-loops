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
  body.drink_milk()
  
  var timer = Timer.new()
  timer.autostart = true
  timer.wait_time = 1
  timer.one_shot = true
  timer.connect("timeout", self, "fireworks")
  add_child(timer)
  
func fireworks() -> void:
  $FireworksParticlesFinal.visible = true
  $FireworksParticlesFinal.emitting = true
  $CheerPlayer.play()
  $NoisePlayer.play()
