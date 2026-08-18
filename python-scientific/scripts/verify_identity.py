#!/usr/bin/env python3
"""Check a symbolic identity and corroborate it at high precision.

This utility deliberately reports two different kinds of evidence:

* a SymPy simplification of ``lhs - rhs``; and
* deterministic numerical evaluations at exact rational/algebraic points.

Numerical agreement is only a sanity check.  It is never a substitute for a
mathematical proof or a Lean proof.

Examples
--------
    python3 verify_identity.py "sin(2*x)" "2*sin(x)*cos(x)"
    python3 verify_identity.py "x**2 + 2*x + 1" "(x + 1)**2" y
    python3 verify_identity.py "1/x" "x**(-1)" --digits 80 --seed 7
"""

from __future__ import annotations

import argparse
import random
import sys
from collections.abc import Iterable

import sympy as sp


def _parse_expression(expression: str, variable: sp.Symbol) -> sp.Expr:
    """Parse an expression while binding the requested variable explicitly."""

    try:
        parsed = sp.sympify(expression, locals={variable.name: variable})
    except (SyntaxError, TypeError, ValueError) as exc:
        raise ValueError(f"no se pudo interpretar {expression!r}: {exc}") from exc

    extra_symbols = parsed.free_symbols - {variable}
    if extra_symbols:
        names = ", ".join(sorted(str(symbol) for symbol in extra_symbols))
        raise ValueError(
            "la expresión contiene variables no declaradas: "
            f"{names}. Usa una sola variable o amplía el script."
        )
    return parsed


def _test_points(samples: int, seed: int) -> list[sp.Expr]:
    """Return deterministic points, avoiding an accidental dependence on floats."""

    points: list[sp.Expr] = [
        sp.Rational(1, 10),
        sp.Rational(1, 2),
        sp.Rational(6, 5),
        sp.Rational(27, 10),
        sp.pi / 4,
    ]
    rng = random.Random(seed)
    seen = {str(point) for point in points}
    for _ in range(max(0, samples)):
        point = sp.Rational(rng.randint(-50, 50), 10)
        if str(point) not in seen:
            points.append(point)
            seen.add(str(point))
    return points


def _finite_value(expr: sp.Expr, variable: sp.Symbol, point: sp.Expr, digits: int) -> sp.Expr | None:
    """Evaluate one side, returning ``None`` at a singular/undefined point."""

    value = sp.N(expr.subs(variable, point), digits)
    if value.has(sp.zoo, sp.oo, -sp.oo, sp.nan):
        return None
    if not value.is_finite:
        return None
    return value


def _finite_difference(
    lhs: sp.Expr,
    rhs: sp.Expr,
    difference: sp.Expr,
    variable: sp.Symbol,
    point: sp.Expr,
    digits: int,
) -> sp.Expr | None:
    """Evaluate a difference, returning ``None`` at a singular point.

    The two sides are evaluated separately first. This preserves domain
    information that may disappear when SymPy simplifies ``lhs - rhs`` to
    zero, as in ``1/x - 1/x`` at ``x = 0``.
    """

    if (
        _finite_value(lhs, variable, point, digits) is None
        or _finite_value(rhs, variable, point, digits) is None
    ):
        return None

    value = sp.N(difference.subs(variable, point), digits)
    if value.has(sp.zoo, sp.oo, -sp.oo, sp.nan) or not value.is_finite:
        return None
    absolute_value = sp.N(sp.Abs(value), digits)
    if not absolute_value.is_finite:
        return None
    return absolute_value


def verify_identity(
    lhs_str: str,
    rhs_str: str,
    var_name: str = "x",
    *,
    digits: int = 50,
    samples: int = 5,
    seed: int = 42,
    points: Iterable[sp.Expr] | None = None,
) -> bool:
    """Verify an identity symbolically and numerically.

    The return value is suitable for a command-line exit status.  A numerical
    evaluation at a singular point is skipped, while a valid point at which the
    expressions differ makes the check fail.
    """

    if digits < 20:
        raise ValueError("digits debe ser al menos 20")
    if not var_name.isidentifier():
        raise ValueError(f"nombre de variable no válido: {var_name!r}")

    variable = sp.Symbol(var_name)
    lhs = _parse_expression(lhs_str, variable)
    rhs = _parse_expression(rhs_str, variable)

    print(f"LHS: {lhs}")
    print(f"RHS: {rhs}")

    difference = sp.simplify(sp.trigsimp(lhs - rhs))
    if difference != 0:
        # These transformations often expose a zero that plain simplify leaves
        # in a rational or factored form; failure still remains inconclusive.
        difference = sp.factor(sp.together(difference))
    symbolic_match = difference == 0
    print(f"Diferencia simbólica simplificada: {difference}")
    print(f"Identidad verificada simbólicamente: {symbolic_match}")

    tolerance = sp.Float(10) ** (-(digits - 10))
    numerical_match = True
    valid_points = 0
    max_difference: sp.Expr | None = None
    evaluation_points = list(points) if points is not None else _test_points(samples, seed)

    for point in evaluation_points:
        difference_value = _finite_difference(lhs, rhs, difference, variable, point, digits)
        if difference_value is None:
            print(f"Punto {point}: omitido (expresión no definida)")
            continue

        valid_points += 1
        if max_difference is None or difference_value > max_difference:
            max_difference = difference_value
        if difference_value > tolerance:
            numerical_match = False
        print(f"Punto {point}: |LHS - RHS| = {difference_value}")

    if valid_points == 0:
        numerical_match = False
        print("Comprobación numérica: inconclusa (no hay puntos válidos).")
    else:
        print(f"Máxima diferencia numérica: {max_difference}")
        print(
            f"Coincidencia numérica ({digits} dps, tolerancia {tolerance}): "
            f"{numerical_match}"
        )

    return symbolic_match and numerical_match


def _argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("lhs", help="lado izquierdo de la identidad")
    parser.add_argument("rhs", help="lado derecho de la identidad")
    parser.add_argument("variable", nargs="?", default="x", help="variable (por defecto: x)")
    parser.add_argument("--digits", type=int, default=50, help="precisión decimal (por defecto: 50)")
    parser.add_argument("--samples", type=int, default=5, help="puntos racionales adicionales")
    parser.add_argument("--seed", type=int, default=42, help="semilla de los puntos adicionales")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = _argument_parser().parse_args(argv)
    try:
        success = verify_identity(
            args.lhs,
            args.rhs,
            args.variable,
            digits=args.digits,
            samples=args.samples,
            seed=args.seed,
        )
    except ValueError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 2
    return 0 if success else 1


if __name__ == "__main__":
    raise SystemExit(main())
