from setuptools import setup, find_packages

setup(
    name="autolayers",
    version="0.1.0",
    description="AutoLayers - Cross-platform QMK layer management",
    packages=find_packages(),
    install_requires=[
        "psutil",
        "pyusb",
        "hidapi",
        "hid>=1.0.7",
    ],
    entry_points={
        "console_scripts": [
            "autolayers=autolayers.main:main",
        ],
    },
)
