extends CharacterBody3D
const VELOCIDADE := 2.0
const GRAVIDADE := 9.8

func _physics_process(delta: float) -> void:
	if GameManager.jogo_encerrado:
		return

	var direcao := Vector3.ZERO

	direcao.x = Input.get_axis("move_left", "move_right")
	direcao.z = Input.get_axis("move_forward", "move_back")

	direcao = direcao.normalized()

	velocity.x = direcao.x * VELOCIDADE
	velocity.z = direcao.z * VELOCIDADE
	
	if not is_on_floor():
		velocity.y -= GRAVIDADE * delta

	move_and_slide()
