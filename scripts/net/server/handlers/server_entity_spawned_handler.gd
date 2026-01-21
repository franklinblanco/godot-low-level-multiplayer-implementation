class_name ServerEntitySpawnedHandler extends Node

@onready var world: World = $"../WorldParent"
@onready var server: Server = $"../Server"

func _ready() -> void:
	ServerSignals.on_spawn_player.connect(handle_spawn_player)

func handle_spawn_player(player_id) -> void:
	var player_entity: Player = Player.create(RNG.generate_random_id(), "Player " + str(player_id), player_id)
	world.spawn_entity(player_entity)
	var entity_spawned: EntitySpawned = EntitySpawned.create(player_entity)
	entity_spawned.broadcast(server.connection)
