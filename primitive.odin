package rat

import "core:fmt"
import "vendor:raylib"

Shape :: union {
	[2]f32, // rectangle bounds
	f32, // radius
}

RectangleWrapper :: struct {
	bounds: [2]f32,
	color:  raylib.Color,
}

CircleWrapper :: struct {
	radius: f32,
	color:  raylib.Color,
}

// specific render calls

render_primitive_rects :: proc(world: ^World) {
	for i in 0 ..< world.primitives_rect.count {
		eid := world.primitives_rect.dense[i]
		wrapper := &world.primitives_rect.data[i]

		// draw
		transform, has_transform := get(&world.transforms, eid)
		if has_transform {
			raylib.DrawRectanglePro(
				raylib.Rectangle(
					{
						transform.position.x,
						transform.position.y,
						wrapper.bounds[0] * transform.scale[0],
						wrapper.bounds[1] * transform.scale[1],
					},
				),
				raylib.Vector2{0, 0}, // FIXME : hardcoded topleft
				transform.rotation,
				wrapper.color,
			)
		}
	}
}

render_primitive_circs :: proc(world: ^World) {
	for i in 0 ..< world.primitives_circ.count {
		eid := world.primitives_circ.dense[i]
		wrapper := &world.primitives_circ.data[i]

		// draw
		transform, has_transform := get(&world.transforms, eid)
		if has_transform {
			raylib.DrawCircleV(transform.position, wrapper.radius, wrapper.color)
		}
	}
}
