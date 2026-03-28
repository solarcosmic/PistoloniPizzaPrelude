extends Area3D

@export var direction: Vector3
var speed = 30

func _ready() -> void:
	set_as_top_level(true)
	_self_destruction()

func _physics_process(delta: float) -> void:
	if not direction:
		return
	
	global_position += direction * speed * delta

func _self_destruction():
	get_tree().create_timer(2).timeout.connect(queue_free)

func _on_area_entered(area: Area3D) -> void:
	queue_free()
	#if area.has_method("take_damage"):
	#	area.take_damage(1)
	#	queue_free()


func _on_body_entered(body: Node3D) -> void:
	var hit = global_position
	
	queue_free()
