extends CharacterBody3D

@export var pontos_patrulha: Array[Marker3D] = []

var indice_patrulha := 0

const VELOCIDADE := 1.5

const DISTANCIA_CHEGADA := 0.2

func _physics_process(_delta: float) -> void:
	var alvo := pontos_patrulha[indice_patrulha]
	var direcao := alvo.global_position - global_position
	direcao.y = 0
	
	if direcao.length() < DISTANCIA_CHEGADA:
		indice_patrulha += 1
		if indice_patrulha == pontos_patrulha.size():
			indice_patrulha = 0
	
	velocity = direcao.normalized() * VELOCIDADE
	look_at(global_position + velocity)
	move_and_slide()

func _ready() -> void:
	$AreaDeteccao.body_entered.connect(_ao_detectar_corpo_entrar)

func _ao_detectar_corpo_entrar(corpo: Node3D) -> void:
	if corpo.is_in_group("player"):
		print("Te vi!")
