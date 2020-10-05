extends Spatial

var loop_timer: Timer

func _init() -> void:
  randomize()

func _ready() -> void:
  loop_timer = Timer.new()
  loop_timer.autostart = true
  loop_timer.wait_time = 3
  loop_timer.connect("timeout", self, "generate_loop")
  add_child(loop_timer)
  
func generate_loop() -> void:
  var loop_scene = load("res://src/Loop.tscn")
  var loop_instance = loop_scene.instance()
  loop_instance.set_name("Loop" + str(randi()))

  var rng = RandomNumberGenerator.new()
  rng.randomize()
  loop_instance.translation.y = 1
  loop_instance.translation.x = rng.randi_range(-9, 9)
  loop_instance.translation.z = rng.randi_range(-9, 9)

  add_child(loop_instance)
