extends KinematicBody

const speed = 8
const max_score = 8

var active = true
var velocity := Vector3()
var crunch_sounds := []
var score = 2

func _init() -> void:
  for s in [1,2,3]:
    var audio_file = "res://assets/crunch" + str(s) + ".wav"
    if File.new().file_exists(audio_file):
      crunch_sounds.append(load(audio_file))

func _physics_process(_delta: float) -> void:
  if active:
    get_input()
  
  velocity = move_and_slide(velocity)
  
  if active:
    if velocity.x != 0 || velocity.z != 0:
      $Sprite.play("run")
    else:
      $Sprite.stop()
  
  if velocity.x > 0:
    $Sprite.flip_h = false
  elif velocity.x < 0:
    $Sprite.flip_h = true

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

func add_score() -> void:
  if score >= max_score:
    return    

  score += 1
  
  var text = "Eat l"
  for _i in range(score):
    text += "o"
  text += "ps!"

  $Camera/LoopsLabel/Viewport/LoopsText.text = text
  
  if score >= max_score:
    $Camera/LoopsLabel/Viewport/LoopsStrike.visible = true
    $Camera/LoopsLabel/Viewport/LoopsText.text += "\nGet milk!"
    
    get_parent().create_milk()

func crunch() -> void:
  open_mouth()

  $AudioStreamPlayer.stream = crunch_sounds[randi() % crunch_sounds.size()]
  $AudioStreamPlayer.play()
  
  add_score()

func open_mouth() -> void:
  if not $Mouth.is_playing():
    $Mouth.frame = 0
    $Mouth.play()

func drink_milk() -> void:
  open_mouth()
  active = false
  velocity = Vector3()
  
  $Sprite.play("dance")
  $Sprite.playing = true
  
  $Camera/LoopsLabel/Viewport/MilkStrike.visible = true
  $Camera/LoopsLabel/Viewport/LoopsText.text += "\nDone!"
  
