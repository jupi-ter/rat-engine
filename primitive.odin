package rat

import "vendor:raylib"

// Data transfer object for both collisions and primitives, since they share these values.
// Not used specifically outside of passing as a parameter to build the actual types.
Shape :: union {
	[2]f32, // rectangle bounds
	f32, // radius
}

// these need to be structs for #soa to work
// structs for both primitives and collisions.
rectangle_t :: struct {
	width, height: f32,
}

Circle :: struct {
	radius: f32,
}

// specific render calls

render_primitive_rects :: proc(world: ^World) {
	for i in 0 ..< world.primitives_rect.count {
		eid := world.primitives_rect.dense[i]
		rect := &world.primitives_rect.data[i]

		// draw
		transform, _ := get(&world.transforms, eid)
		appearance, _ := get(&world.appearances, eid)

		raylib.DrawRectanglePro(
			raylib.Rectangle(
				{
					transform.position.x,
					transform.position.y,
					rect.width * transform.scale[0],
					rect.height * transform.scale[1],
				},
			),
			raylib.Vector2{0, 0}, // FIXME : hardcoded topleft
			transform.rotation,
			appearance.tint,
		)
	}
}

render_primitive_circs :: proc(world: ^World) {
	for i in 0 ..< world.primitives_circ.count {
		eid := world.primitives_circ.dense[i]
		circle := &world.primitives_circ.data[i]

		// draw
		transform, _ := get(&world.transforms, eid)
		appearance, _ := get(&world.appearances, eid)
		raylib.DrawCircleV(transform.position, circle.radius, appearance.tint)
	}
}
