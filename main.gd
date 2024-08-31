extends Node2D

@onready var NO = preload("res://no.tscn");

var raiz: No;
var id: int = 6;

## Pra função draw
var lines: Array[Dictionary] = [];
var posInicio: Vector2;
var posFinal: Vector2;

func _ready():
	pass;

func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_ENTER:
			print("Enter pressionado")
			criarNo();
			#queue_redraw();

func _process(delta):
	pass

func criarNo():
	var novoNo: No = instanciarNo();
	
	if !novoNo:
		return;
	
	if !raiz:
		print("Criando a raiz")
		raiz = novoNo;
		raiz.left_pos.position.x += -50;
		raiz.right_pos.position.x += 50;
		raiz.set_new_position(%raizPos.global_position, 1);
		return;
	else:
		print("Raiz ja criada")
		inserirNo(raiz, novoNo);
	
func inserirNo(raizAtual: No, novo: No, depth=1):
	var actualDepth = depth;
	
	if !raizAtual or raizAtual.num == novo.num:
		print("raiz nula ou numero ja existe")
		novo.queue_free();
		return;
	
	if novo.num > raizAtual.num:
		if !raizAtual.right:
			raizAtual.right = novo
			novo.set_new_position(raizAtual.right_pos.global_position, depth);
			#self.draw_line(raizAtual.global_position, novo.global_position, Color.RED, 1);
			add_line(raizAtual, novo);
			print("Adicionando a direita")
		else:
			inserirNo(raizAtual.right, novo, depth + 1);
	else:
		if !raizAtual.left:
			raizAtual.left = novo;
			novo.set_new_position(raizAtual.left_pos.global_position, depth);
			#draw_line(raizAtual.global_position, novo.global_position, Color.RED, 1);
			add_line(raizAtual, novo);
			print("Adicionando a esquerda")
		else:
			inserirNo(raizAtual.left, novo, depth + 1);
			

func instanciarNo():
	
	var inputText: String = %inputText.text;
	%inputText.clear();
	
	if inputText.is_empty() or !inputText.is_valid_int():
		print_rich("[color=red]Caractere inválido")
		return;
	
	var numAtual: int = int(inputText);
	
	#id += 1;
	
	print("instanciando um novo no para %d" % [numAtual])
	
	if !(numAtual is int):
		print_rich("[color=red]Invalido");
		return null;
	
	var novoNo: No = NO.instantiate() as No;
	novoNo.depth = 1
	add_child(novoNo);
	novoNo.set_num(numAtual);
	
	return novoNo;

func _draw():
	
	for line: Dictionary in lines:
		draw_line(line.pai.global_position, line.filho.global_position, Color.RED, 2);

func add_line(pai: No, filho: No):
	lines.push_back({
		"pai": pai,
		"filho": filho
	});
	queue_redraw();

func remove_line(no: No):
	lines = lines.filter(
		func (line): 
			return line.filho != no;
	)
	queue_redraw();

func clear_tree(_raiz: No):
	
	_raiz.set_color(Color.BLUE)
	await get_tree().create_timer(0.5).timeout;
	
	if _raiz.is_leaf(_raiz):
		
		_raiz.set_color(Color.RED)
		await get_tree().create_timer(0.5).timeout;
		
		remove_line(_raiz);
		_raiz.queue_free();
		return;
	
	if _raiz.right:
		await clear_tree(_raiz.right);
		
	if _raiz.left:
		await clear_tree(_raiz.left)
	
	_raiz.set_color(Color.RED)
	await get_tree().create_timer(0.5).timeout;
	
	remove_line(_raiz);
	_raiz.queue_free();
	return;

func _on_button_pressed():
	print("Criando nó!")
	criarNo();

func _on_clear_button_pressed():
	if raiz != null:
		await clear_tree(raiz);
