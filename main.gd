extends Node2D

@onready var NO = preload("res://no.tscn");

var raiz: No;
var id: int = 6;

## Pra função draw
var lines: Array = [];
var posInicio: Vector2;
var posFinal: Vector2;

func _ready():
	#criarNo();
	#criarNo();
	#criarNo();
	pass;

func _process(delta):
	pass

func criarNo():
	var novoNo: No = instanciarNo();
	
	if !raiz:
		print("Criando a raiz")
		raiz = novoNo;
		raiz.left_pos.position.x += -50;
		raiz.right_pos.position.x += 50;
		raiz.set_new_position(%raizPos.global_position);
		return;
	else:
		print("Raiz ja criada")
		inserirNo(raiz, novoNo);
	
func inserirNo(raizAtual: No, novo: No):
	
	if !raizAtual or raizAtual.num == novo.num:
		print("raiz nula ou numero ja existe")
		novo.queue_free();
		return;
	
	if novo.num > raizAtual.num:
		if !raizAtual.right:
			raizAtual.right = novo
			novo.set_new_position(raizAtual.right_pos.global_position);
			#self.draw_line(raizAtual.global_position, novo.global_position, Color.RED, 1);
			add_line(raizAtual.global_position, novo.global_position);
			print("Adicionando a direita")
		else:
			inserirNo(raizAtual.right, novo);
	else:
		if !raizAtual.left:
			raizAtual.left = novo;
			novo.set_new_position(raizAtual.left_pos.global_position);
			#draw_line(raizAtual.global_position, novo.global_position, Color.RED, 1);
			add_line(raizAtual.global_position, novo.global_position);
			print("Adicionando a esquerda")
		else:
			inserirNo(raizAtual.left, novo);
			
func _on_button_pressed():
	print("botão pressionado")
	criarNo();
	%inputText.clear();

func instanciarNo():
	var numAtual: int = int(%inputText.text);
	
	#id += 1;
	
	print("instanciando um novo no para %d" % [numAtual])
	
	if !(numAtual is int):
		print("Invalido");
		return;
	
	var novoNo: No = NO.instantiate();
	add_child(novoNo);
	novoNo.set_num(numAtual);
	
	return novoNo;

func _draw():
	print("quenga")
	#draw_multiline(lines, Color.RED, 2)
	
	for line in lines:
		print(line)
		draw_line(line[0], line[1], Color.RED, 2);

func add_line(inicio: Vector2, fim: Vector2):
	#posInicio = inicio;
	#posFinal = fim;
	
	lines.push_back([inicio, fim]);
	print(lines)
	queue_redraw();
	
