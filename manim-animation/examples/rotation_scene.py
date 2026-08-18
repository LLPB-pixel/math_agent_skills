"""Minimal Manim scene used by the manim-animation skill."""

from manim import Arrow, BLUE, Create, MathTex, NumberPlane, ORIGIN, RIGHT, Scene, UL, UP, Write


class RotationScene(Scene):
    """Animate the action of a 90-degree rotation matrix."""

    def construct(self) -> None:
        matrix = [[0, -1], [1, 0]]
        plane = NumberPlane()
        vector = Arrow(ORIGIN, 2 * RIGHT + UP, color=BLUE)
        matrix_tex = MathTex(
            r"R = \begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}"
        ).to_corner(UL)

        self.play(Create(plane), Create(vector), Write(matrix_tex))
        self.wait()
        self.play(
            plane.animate.apply_matrix(matrix),
            vector.animate.apply_matrix(matrix),
            run_time=2,
        )
        self.wait()
