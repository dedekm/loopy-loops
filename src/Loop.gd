extends Spatial

var colors = [Color("#ccffcc"),
              Color("#ffe599"),
              Color("#fad7ff")]

func _ready() -> void:
  var material = SpatialMaterial.new()
  material.albedo_color = colors[randi() % colors.size()]
  material.flags_unshaded = true
  $Torus001.set_surface_material(0, material)

func _on_Area_body_entered(_body: Node) -> void:
  queue_free()
