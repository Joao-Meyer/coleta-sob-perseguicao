extends Node3D

func _ready() -> void:
	GameManager.total_itens = $Itens.get_child_count()
