extends Node2D

signal on_draw()


var continue_scene: String = "res://menus/continue/continue_scene.tscn"


@onready var p1SpawnPos = $"../p1_spawn_pos"
@onready var p2SpawnPos = $"../p2_spawn_pos"
@onready var camPos
@onready var camera = $"../Camera"

@onready
var charnode = $"../chars"

@onready
var feedback: Feedback = $"../layer/feedback"

@onready
var attacklabel: attackdata = $"../control_layer/control_training/data/labels/attacklabel"
@onready
var frameslabel: attackdata = $"../control_layer/control_training/data/labels/frameslabel"
@onready
var damagelabel: attackdata = $"../control_layer/control_training/data/labels/damagelabel"
@onready
var knockbacklabel: attackdata = $"../control_layer/control_training/data/labels/knockbacklabel"

var p1_win: bool = false
var p2_win: bool = false


var p1:P1Character 
var p2:P2Character

var health_p1
var health_p2
var p2_combo_hits


var p1_block_stun_frames: int 
var p1_hit_stun_frames
var p1_attack_hurt_type
var p1_attack_damage
var p1_attack_knockback
var p1_attack_knockback_y

var p2_block_stun_frames: int
var p2_hit_stun_frames
var p2_attack_hurt_type
var p2_attack_damage
var p2_attack_knockback
var p2_attack_knockback_y

# Change Scene Func
func go_to_continue() -> void:
	get_tree().change_scene_to_file(continue_scene)


# Flip Chars Funcs
func p1_is_on_right_side() -> void:
	var p1_pos = p1.position.x
	var p2_pos = p2.position.x
	
	if p1_pos > p2_pos and !p1.on_right_side:
		p1.on_right_side = true
		p1.flip_char()
		
	if p1_pos < p2_pos and p1.on_right_side:
		p1.on_right_side = false
		p1.flip_char()

func p2_is_on_right_side() -> void:
	var p1_pos = p1.position.x
	var p2_pos = p2.position.x
	
	if p2_pos > p1_pos and !p2.on_right_side:
		p2.on_right_side = true
		p2.flip_char()
		
	if p2_pos < p1_pos and p2.on_right_side:
		p2.on_right_side = false
		p2.flip_char()
		
		
# Set infos Funcs
func p1_set_hit_info(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int, knockback_y: int, hit_variant: String) -> void:

	Hitstop.hitstop(0.05, 0.25)

	p1_hit_stun_frames = block_stun_frames
	p1_block_stun_frames = hit_stun_frames
	p1_attack_damage = damage
	p1_attack_knockback = knockback
	p1_attack_knockback_y = knockback_y
	p1_attack_hurt_type = hit_variant
	
	set_p2_hurt_vars(block_stun_frames, hit_stun_frames, hit_variant, knockback, knockback_y)
	
	
func p2_set_hit_info(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int, knockback_y: int, hit_variant: String) -> void:
	
	Hitstop.hitstop(0.05, 0.25)
	
	p2_hit_stun_frames = block_stun_frames
	p2_block_stun_frames = hit_stun_frames
	p2_attack_damage = damage
	p2_attack_knockback = knockback
	p2_attack_knockback_y = knockback_y
	p2_attack_hurt_type	 = hit_variant
	
	set_p1_hurt_vars(block_stun_frames, hit_stun_frames, hit_variant, knockback, knockback_y)

func set_p1_hurt_vars(block_stun_frames: int, hit_stun_frames: int, hurt_type : String, knockback: int, knockback_y: int) -> void:
	
	p1.block_stun_frames = block_stun_frames
	p1.hit_stun_frames = hit_stun_frames
	p1.hurt_type = hurt_type
	p1.knockback = knockback
	p1.knockback_y = knockback_y
		
func set_p2_hurt_vars(block_stun_frames: int, hit_stun_frames: int, hurt_type : String, knockback: int, knockback_y: int) -> void:
	
	p2.block_stun_frames = block_stun_frames
	p2.hit_stun_frames = hit_stun_frames
	p2.hurt_type = hurt_type
	p2.knockback = knockback
	p2.knockback_y = knockback_y

func p1_wins() -> void:
	if !p1_win:
		p1_win = true
		print("p1 wins!")
		GlobalSignals.timer.stop()
		feedback.p1_wins()
		await get_tree().create_timer(3).timeout
		go_to_continue()
	
func p2_wins() -> void:
	if !p2_win:
		p2_win = true
		print("p2 wins!")
		GlobalSignals.timer.stop()
		feedback.p2_wins()
		await get_tree().create_timer(3).timeout
		go_to_continue()

func on_timeout() -> void:
	pass

func start_timer() -> void:
	GlobalSignals.timer.start(3)

func _ready() -> void:
	
	await get_tree().process_frame
	call_deferred("_late_start")
	GlobalSignals.timer.connect("timeout", on_timeout)

func _late_start():
	if charnode.has_node("p1_instance"):
		p1 = charnode.get_node("p1_instance")

	if charnode.has_node("p2_instance"):
		p2 = charnode.get_node("p2_instance")

	# conecta os hitboxes
	if p1:
		var p1_hitbox_manager = p1.get_node("hitbox_manager")
		p1.connect("hurt",p1_update_health)
		p1.connect("hurt", p2.set_sp)
		p1.connect("is_ready", p1.start_game)
		p1.connect("p1_dead", p2_wins)
		p1.connect("p1_lose", p2_wins)
		p1.connect("p1_dead", p2.win_game)
		p1.connect("p1_lose", p2.win_game)
		p1.connect("p1_lose", p2.lose_game)
		connect("on_draw" , p1.draw_game)
		health_p1 = p1.get_node("health/CanvasLayer/health_bar")
		p1_hitbox_manager.connect("hit", p1_set_hit_info)
		CharsGlobals.p1hitboxall = p1_hitbox_manager
		p1.sp = 1000

		
	if p2:
		var p2_hitbox_manager = p2.get_node("hitbox_manager")
		p2.connect("hurt", p2_update_health)
		p2.connect("hurt", p1.set_sp)
		p2.connect("is_ready", p2.start_game)
		p2.connect("p2_dead", p1_wins)
		p2.connect("p2_lose", p1_wins)
		p2.connect("p2_dead", p1.win_game)
		p2.connect("p2_lose", p1.win_game)
		p2.connect("p2_lose", p2.lose_game)
		connect("on_draw" , p2.draw_game)
		health_p2 = p2.get_node("health/CanvasLayer/health_bar")
		p2_combo_hits = health_p2.get_node("combo_hits")
		p2_hitbox_manager.connect("hit", p2_set_hit_info)
		CharsGlobals.p2hitboxall = p2_hitbox_manager
		p2.sp = 1000
		GlobalSignals.timer4.timeout.emit()
		
	if camera:
		camPos = camera.get_node("camera")
		
	
func update_info() -> void:
	
	attacklabel.value = p1_attack_hurt_type
	if p1_block_stun_frames < 0:
		frameslabel.value = p2.block_stun_frames
	else: 
		frameslabel.value = p2.hit_stun_frames
	damagelabel.value = p1_attack_damage
	knockbacklabel.value = p1_attack_knockback
	
	
func p1_update_health() -> void:
	health_p1._set_health(p1.health - p2_attack_damage)
	p1.health -= p2_attack_damage

	
func p2_update_health() -> void:
	health_p2._set_health(p2.health - p1_attack_damage)
	p2.health -= p1_attack_damage

func reset_sp_health() -> void:
	
	p1.health = 10000
	p1.sp = 1000
	
	p2.health = 10000
	p2.sp = 1000
	
	p1.global_position = p1SpawnPos.global_position
	p2.global_position = p2SpawnPos.global_position
	camPos.global_position = Vector2(630, 511)

func _process(delta: float) -> void:
	
	if p1 and p2:
		update_info()
		
		if Input.is_action_just_pressed("p1_back"):
			reset_sp_health()
		
	if p1 and p1.is_on_floor():
		p1_is_on_right_side()

	if p2 and p2.is_on_floor():
		p2_is_on_right_side()
		
	if p1.health <= 200:
		p1.health = 10000
	
	if p2.health <= 200:
		p1.health = 10000

func _physics_process(delta):
	
	if p1:
		p1.apply_push(p2, delta)
		
	if p2:
		p2.apply_push(p1, delta)
		p2_combo_hits.visible = false

	

	
