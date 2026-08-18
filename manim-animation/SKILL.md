---
name: manim-animation
description: Create programmatic mathematical animations, geometric constructions, calculus transformations, and linear algebra visualizations using Manim (Community Edition).
---

# Manim Mathematical Animations

## Purpose

Use Manim to generate high-quality, precise mathematical animations for demonstrating mathematical concepts, dynamic geometric constructions, calculus derivations, transformations, and visual proofs.

Key use cases:
- Visualizing linear transformations and matrix actions on vector spaces.
- Demonstrating limits, derivatives, Riemann sums, and line integrals.
- Animating geometric theorems and constructions.
- Explaining complex mathematical concepts step-by-step.

Use this skill for explanatory visualizations, not as a proof checker. A
sequence of frames can illustrate an argument, but correctness still comes
from the written derivation or from a formal proof in Lean.

## Core Rules

1. Keep animations mathematically accurate and clean.
2. Group logical animation steps into clear `Scene` classes.
3. Use standard LaTeX mathematical formatting inside `MathTex`.
4. Avoid overcrowded scenes; clear or transform objects between concepts.
5. Render animations at lower resolution (`-ql`) during development, and high resolution (`-qh`) for final artifacts.
6. Use raw Python strings for LaTeX containing backslashes and test a low-quality render before presenting a scene as complete.

## Structure of a Manim Scene

```python
from manim import *

class LinearTransformationScene(Scene):
    def construct(self):
        # 1. Create mathematical objects
        title = Title("Linear Transformation: Rotation & Scaling")
        grid = NumberPlane()
        matrix = [[0, -1], [1, 0]]  # 90 degree rotation

        matrix_tex = MathTex(
            r"\begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}"
        ).to_corner(UL)

        # 2. Add initial state
        self.play(Write(title))
        self.play(Create(grid))
        self.play(Write(matrix_tex))
        self.wait(1)

        # 3. Animate transformation
        self.play(grid.animate.apply_matrix(matrix), run_time=3)
        self.wait(2)
```

## Common Mathematical Animation Patterns

### 1. Mathematical Equations & Transformations (`MathTex`)

```python
class EquationDerivation(Scene):
    def construct(self):
        eq1 = MathTex("e^{i\\theta}", "=", "\\cos\\theta + i\\sin\\theta")
        eq2 = MathTex("e^{i\\pi}", "=", "-1")
        
        self.play(Write(eq1))
        self.wait(1)
        self.play(TransformMatchingShapes(eq1, eq2))
        self.wait(1)
```

### 2. Calculus & Functions (`Axes` / `ImplicitFunction`)

```python
class RiemannSumAnimation(Scene):
    def construct(self):
        axes = Axes(x_range=[0, 5], y_range=[0, 10])
        graph = axes.plot(lambda x: x**2, color=BLUE)
        riemann = axes.get_riemann_rectangles(graph, x_range=[0, 3], dx=0.5)

        self.play(Create(axes), Create(graph))
        self.play(Create(riemann))
        self.wait(1)
```

## Rendering Commands

Check that the executable is available before writing a scene:

```bash
manim --version
```

If it is unavailable, report that rendering could not be performed; do not
pretend that a video was generated.

Render scene to video file:

```bash
# Fast low-quality preview (480p, 15fps)
manim -ql scene.py SceneName

# High-quality final render (1080p, 60fps)
manim -qh scene.py SceneName

# Output transparent PNG frame of last frame
manim -s -ql scene.py SceneName

# Repository example
manim -ql manim-animation/examples/rotation_scene.py RotationScene
```

## Output & Media Handling

- Rendered videos are output to `media/videos/scene/1080p60/SceneName.mp4`.
- Use low resolution (`-ql`) to rapidly test animations.
- Check that the expected file exists and inspect the rendered video or a representative frame before embedding it in a report.
- Keep generated `media/` outside version control unless a final artifact is intentionally released.
- Label animations as visual explanations, never as formal verification.
