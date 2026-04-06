package rat

import "vendor:raylib"

World :: struct {
	entity_manager: EntityManager,
	transforms:     SparseSet(transform_t),
	renderables:    SparseSet(Renderable),
	colliders_aabb: SparseSet(RectCollision),
	colliders_circ: SparseSet(CircCollision),
	sprite_lib:     SpriteLibrary,
	grid:           SpatialGrid,
}

create_world :: proc() -> World {
	return World {
		entity_manager = create_entity_manager(),
		transforms = create_sparse_set(transform_t, MAX_ENTITIES),
		renderables = create_sparse_set(Renderable, MAX_ENTITIES),
		colliders_aabb = create_sparse_set(RectCollision, MAX_ENTITIES),
		colliders_circ = create_sparse_set(CircCollision, MAX_ENTITIES),
		sprite_lib = init_sprite_lib(),
		grid = create_spatial_grid(),
	}
}

create_object :: proc(
	world: ^World,
	transform: transform_t,
	image: ImageParams,
	bbox: CollisionConfig,
) -> Entity {
	eid, ok := entity_create(&world.entity_manager)
	assert(ok, "Failed to create entity, EntityManager is out of capacity.")

	add(&world.transforms, eid, transform)

	add(
		&world.renderables,
		eid,
		Renderable {
			sprite_name = image.sprite_name,
			image_index = image.image_index,
			frame_counter = 0,
			image_speed = image.image_speed,
		},
	)

	switch val in bbox {
	case raylib.Vector2:
		add(
			&world.colliders_aabb,
			eid,
			RectCollision{width = raylib.Vector2(val).x, height = raylib.Vector2(val).y},
		)
		break
	case f32:
		add(&world.colliders_circ, eid, CircCollision{radius = val})
		break
	}

	return eid
}
