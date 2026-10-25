extends CharacterBody3D

enum Estado { PATRULHA, PERSEGUICAO }

var estado: Estado = Estado.PATRULHA
var referencia_jogador: Node3D = null

@export var pontos_patrulha: Array[Marker3D] = []

var indice_patrulha := 0

const VELOCIDADE_BASE := 1.5

var velocidade_atual := VELOCIDADE_BASE

const DISTANCIA_CHEGADA := 0.2

func _physics_process(_delta: float) -> void:
	velocidade_atual = VELOCIDADE_BASE * GameManager.dificuldade
	
	if estado == Estado.PATRULHA:
		_patrulhar()
	else:
		_perseguir()
		
	look_at(global_position + velocity)
	move_and_slide()

func _patrulhar() -> void:
	var alvo := pontos_patrulha[indice_patrulha]
	var direcao := alvo.global_position - global_position
	direcao.y = 0
	if direcao.length() < DISTANCIA_CHEGADA:
		indice_patrulha += 1
	if indice_patrulha == pontos_patrulha.size():
		indice_patrulha = 0
	velocity = direcao.normalized() * velocidade_atual
	
func _perseguir() -> void:
	var direcao := referencia_jogador.global_position - global_position
	direcao.y = 0
	velocity = direcao.normalized() * velocidade_atual

func _ready() -> void:
	$AreaDeteccao.body_entered.connect(_ao_detectar_corpo_entrar)
	$AreaDeteccao.body_exited.connect(_ao_detectar_corpo_sair)
	$AreaCaptura.body_entered.connect(_ao_capturar_corpo_entrar)

func _ao_capturar_corpo_entrar(corpo: Node3D) -> void:
	if corpo.is_in_group("player"):
		GameManager.perder()

func _ao_detectar_corpo_sair(corpo: Node3D) -> void:
	if corpo.is_in_group("player"):
		referencia_jogador = null
		estado = Estado.PATRULHA

func _ao_detectar_corpo_entrar(corpo: Node3D) -> void:
	if corpo.is_in_group("player"):
		referencia_jogador = corpo
		estado = Estado.PERSEGUICAO
