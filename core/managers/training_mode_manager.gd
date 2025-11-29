extends Node2D

@onready
var charnode = $"../chars"

@onready
var attacklabel: attackdata = $"../control_layer/control_training/data/labels/attacklabel"
@onready
var frameslabel: attackdata = $"../control_layer/control_training/data/labels/frameslabel"
@onready
var damagelabel: attackdata = $"../control_layer/control_training/data/labels/damagelabel"
@onready
var knockbacklabel: attackdata = $"../control_layer/control_training/data/labels/knockbacklabel"

var p1:P1Character 
var p2:P2Character
var health_p1
var health_p2


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


func _ready() -> void:
	call_deferred("_late_start")

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
		health_p1 = p1.get_node("health/CanvasLayer/health_bar")
		p1_hitbox_manager.connect("hit", p1_set_hit_info)
		CharsGlobals.p1hitboxall = p1_hitbox_manager
		p1.sp = 1000
		
	if p2:
		var p2_hitbox_manager = p2.get_node("hitbox_manager")
		p2.connect("hurt", p2_update_health)
		p2.connect("hurt", p1.set_sp)
		health_p2 = p2.get_node("health/CanvasLayer/health_bar")
		p2_hitbox_manager.connect("hit", p2_set_hit_info)
		CharsGlobals.p2hitboxall = p2_hitbox_manager
		p2.sp = 1000
	
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

func _process(delta: float) -> void:
	
	print(p2_attack_knockback)
	
	update_info()
	if p1 and p1.is_on_floor():
		p1_is_on_right_side()

	if p2 and p2.is_on_floor():
		p2_is_on_right_side()
		

func _physics_process(delta):
	
	if p1:
		p1.apply_push(p2, delta)
		
	if p2:
		p2.apply_push(p1, delta)

	

	
