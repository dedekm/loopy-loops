extends Spatial

const colors = [Color("#ccffcc"),
                Color("#ffe599"),
                Color("#fad7ff")]

func _init() -> void:
  var material = SpatialMaterial.new()
  material.albedo_color = colors[randi() % colors.size()]
  material.flags_unshaded = true
  $Torus001.set_surface_material(0, material)

func _on_Area_body_entered(body: Node) -> void:
  if $Torus001.visible:
    $CrunchParticles.mesh = $CrunchParticles.mesh.duplicate()
    $CrunchParticles.mesh.surface_set_material(0, $Torus001.get_surface_material(0))
    
    body.crunch()
    $CrunchParticles.set_emitting(true)
    $Torus001.visible = false
    
    var timer = Timer.new()
    timer.autostart = true
    timer.wait_time = 0.8
    timer.one_shot = true
    timer.connect("timeout", self, "queue_free")
    add_child(timer)
