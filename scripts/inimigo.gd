extends CharacterBody3D

@export var alvo: Marker3D

const VELOCIDADE := 1.5

func _physics_process(_delta: float) -> void:
	var direcao := alvo.global_position - global_position
	
	direcao.y = 0
	
	velocity = direcao.normalized() * VELOCIDADE
	
	move_and_slide()
