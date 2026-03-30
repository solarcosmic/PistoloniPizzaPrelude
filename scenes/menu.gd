extends Node3D

@export var max_offset = 0.05
@export var speed = 2.0
var target_pos = Vector3.ZERO
var center = Vector2.ZERO
var initial = Vector3.ZERO
@onready var camera = $Camera3D

var current_sway = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_viewport().get_visible_rect().size / 2
	initial = camera.rotation
	current_sway = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var offset = (mouse_pos - center) / center
	
	var target_x = -offset.y * max_offset
	var target_y = -offset.x * max_offset
	var target_sway = Vector3(target_x, target_y, 0)
	current_sway = current_sway.lerp(target_sway, speed * delta)
	camera.rotation = initial + current_sway
	#camera.rotation.x = lerp_angle(camera.rotation.x, target_x, speed * delta)
	#camera.rotation.y = lerp_angle(camera.rotation.y, target_y, speed * delta)
	#var target = initial + Vector3(target_x, target_y, 0)
	#camera.rotation = camera.rotation.lerp(target, speed * delta)


func _on_new_game_button_down() -> void:
	print("test")
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
