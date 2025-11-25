extends P1Character

@onready var health_bar: HealthBarP1 = $health
@onready var health_bar_config: HealthBarConfigP1 = $health/CanvasLayer/health_bar

func _ready() -> void:
	super()
	health_bar.text_name = "Ryu"
	health_bar.texture_path = "res://assets/icons/portraits/ryu_port.png"
	health_bar.set_things()
	health_bar_config.init_health(self.health)
	health_bar_config.init_sp(self.sp)
	
func _on_hitbox_manager_hit_check() -> void:
	hit = "hit"
	sp += 50
	health_bar_config._set_sp(sp)
	hit_buffer = 24
	
	pass # Replace with function body.
