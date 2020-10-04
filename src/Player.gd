extends KinematicBody

const speed = 8

var velocity := Vector3()
var crunch_sounds := []

func _init() -> void:
  for s in [1,2,3]:
    var audio_file = "res://assets/crunch" + str(s) + ".wav"
    if File.new().file_exists(audio_file):
      crunch_sounds.append(load(audio_file))

func _physics_process(_delta: float) -> void:
  get_input()
  velocity = move_and_slide(velocity)
  
  if velocity.x != 0 || velocity.z != 0:
    $Sprite.play()
  else:
    $Sprite.stop()

func get_input() -> void:
  velocity.x = 0
  velocity.z = 0
  
  if Input.is_action_pressed("move_forward"):
    velocity.z -= speed
  if Input.is_action_pressed("move_backward"):
    velocity.z += speed
  if Input.is_action_pressed("strafe_right"):
    velocity.x += speed
  if Input.is_action_pressed("strafe_left"):
    velocity.x -= speed
  
  velocity = velocity.normalized() * speed

func crunch() -> void:
  if not $AudioStreamPlayer.playing:
      $AudioStreamPlayer.stream = crunch_sounds[randi() % crunch_sounds.size()]
      $AudioStreamPlayer.play()
