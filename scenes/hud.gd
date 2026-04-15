extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_recenter()
	get_viewport().size_changed.connect(_recenter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _recenter():
	$AnimatedSprite2D.position = get_viewport().size / 2

#func _on_ui_update_schedule_timeout() -> void:
#	$AnimatedSprite2D.position = get_viewport().size / 2
