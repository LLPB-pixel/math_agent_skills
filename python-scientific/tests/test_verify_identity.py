"""Standard-library tests for the identity verification helper."""

from __future__ import annotations

import importlib.util
import unittest
from pathlib import Path

import sympy as sp


SCRIPT = Path(__file__).parents[1] / "scripts" / "verify_identity.py"
SPEC = importlib.util.spec_from_file_location("verify_identity", SCRIPT)
if SPEC is None or SPEC.loader is None:  # pragma: no cover - import guard
    raise ImportError(f"cannot load {SCRIPT}")
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class VerifyIdentityTests(unittest.TestCase):
    def test_exact_identity(self) -> None:
        self.assertTrue(
            MODULE.verify_identity(
                "sin(2*x)",
                "2*sin(x)*cos(x)",
                samples=0,
                points=[sp.Rational(1, 3), sp.pi / 4],
            )
        )

    def test_false_identity_is_rejected(self) -> None:
        self.assertFalse(
            MODULE.verify_identity(
                "x**2",
                "x",
                samples=0,
                points=[sp.Rational(1, 2)],
            )
        )

    def test_singular_points_are_skipped(self) -> None:
        self.assertTrue(
            MODULE.verify_identity(
                "1/x",
                "x**(-1)",
                samples=0,
                points=[sp.Rational(0), sp.Rational(2)],
            )
        )

    def test_undeclared_symbols_are_rejected(self) -> None:
        with self.assertRaises(ValueError):
            MODULE.verify_identity("x + y", "x + y", samples=0)


if __name__ == "__main__":
    unittest.main()
