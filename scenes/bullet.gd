extends Area3D

@export var direction: Vector3
var speed = 60

func _ready() -> void:
	set_as_top_level(true)
	_self_destruction()

func _physics_process(delta: float) -> void:
	if direction.length_squared() < 0.000001:
		return
	#if not direction:
	#	return
	
	global_position += direction * speed * delta

func _self_destruction():
	get_tree().create_timer(2).timeout.connect(queue_free)

#func _on_area_entered(area: Area3D) -> void:
	#print(area.name)
	#queue_free()
	#if area.has_method("take_damage"):
		#area.take_damage(1)
		#queue_free()


func _on_body_entered(body: Node3D) -> void:
	#var hit = global_position
	if body.get_parent_node_3d().name.contains("Enemy"):
		body.get_parent_node_3d().queue_free()
	queue_free()
