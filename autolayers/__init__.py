"""
AutoLayers - Cross-platform QMK layer management
"""

from dataclasses import dataclass, field
from typing import Dict, Set, Tuple

@dataclass
class Matches:
    layer_1: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_2: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_3: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_4: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_5: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_6: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_7: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_8: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)
    layer_9: Dict[str, Set[str] | str | Tuple[int]] = field(default_factory=dict)

    def __post_init__(self):
        for n in range(1, 10):
            layer_name = f"layer_{n}"
            getattr(self, layer_name)["apps"] = set()

__version__ = "0.1.0"

# Export the Matches class
__all__ = ["Matches"]

"""AutoLayers package initialization""" 