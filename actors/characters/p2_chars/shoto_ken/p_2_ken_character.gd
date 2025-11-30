extends P2Character



@onready var health_bar: HealthBarP2 = $health
@onready var health_bar_config: HealthBarConfigP2 = $health/CanvasLayer/health_bar

var is_dead: bool = false

func _ready() -> void:
	super()
	self.health = 250
	health_bar.text_name = "Ken"
	health_bar.texture_path = "res://assets/icons/portraits/ken_port.png"
	health_bar.set_things()
	health_bar_config.init_health(self.health)
	health_bar_config.init_sp(self.sp)
	
func _process(delta: float) -> void:
	super(delta)
	
	if self.health <= 0 and !is_dead:
		is_dead = true
		state_machine.change_state(dead_state)
		
	health_bar_config._set_sp(sp)	

func set_sp() -> void:
	if sp < 1000:
		sp += 50
	health_bar_config._set_sp(sp)

func _on_hitbox_manager_hit_check() -> void:
	hit = "hit"
	hit_buffer = 24
	
	pass # Replace with function body.
