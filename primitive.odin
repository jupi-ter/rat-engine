package rat

import "vendor:raylib"

Primitive :: union {
	raylib.Rectangle,
	f32, // radius
}

RectangleWrapper :: struct {
	rect:  raylib.Rectangle,
	color: raylib.Color,
}

CircleWrapper :: struct {
	radius: f32,
	color:  raylib.Color,
}

// specific render calls

render_primitive_rects :: proc(world: ^World) {
	for i in 0 ..< world.primitives_rect.count {
		eid := world.renderables.dense[i]
		wrapper := &world.primitives_rect.data[i]

		// draw
		transform, has_transform := get(&world.transforms, eid)
		if has_transform {
			raylib.DrawRectanglePro(
				wrapper.rect,
				transform.position,
				transform.rotation,
				wrapper.color,
			)
		}
	}
}

render_primitive_circs :: proc(world: ^World) {
	for i in 0 ..< world.primitives_circ.count {
		eid := world.renderables.dense[i]
		wrapper := &world.primitives_circ.data[i]

		// draw
		transform, has_transform := get(&world.transforms, eid)
		if has_transform {
			raylib.DrawCircleV(transform.position, wrapper.radius, wrapper.color)
		}
	}
}
