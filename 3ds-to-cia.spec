# -*- mode: python -*-

import sys
import platform
import os

from PyInstaller.utils.hooks import collect_submodules

def get_tools_path():
    bits = "64" if platform.machine().endswith("64") else "32"
    tools_paths = []

    if sys.platform == "win32":
        win32_path = os.path.join("tools", "win32")
        win64_path = os.path.join("tools", "win64")

        if os.path.exists(win32_path):
            tools_paths.append((win32_path, win32_path))
        else:
            print(f"Directory {win32_path} does not exist. Please check the path.")
        
        if os.path.exists(win64_path):
            tools_paths.append((win64_path, win64_path))
        else:
            print(f"Directory {win64_path} does not exist. Please check the path.")

        return tools_paths

    print("Sorry, your OS is not supported yet.")
    sys.exit(1)

block_cipher = None

a = Analysis(
    ['3ds-to-cia.py'],
    binaries=get_tools_path(),
    datas=[
        (os.path.join('tools', 'win32', 'make_cia.exe'), 'tools/win32/'),  # Assurez-vous que le chemin et le nom du fichier sont corrects
        (os.path.join('tools', 'win64', 'make_cia.exe'), 'tools/win64/')  # Assurez-vous que le chemin et le nom du fichier sont corrects
    ],
    hiddenimports=[
        '_frozen_importlib_external',
        'fcntl',
        '_posixsubprocess',
        '_winreg',
        'java',
        'vms_lib',
        'resource',
        'posix',
        'pwd',
        'grp',
        'java.lang'
    ],
    hookspath=[],
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher
)
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)
exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    name='Convertion 3ds à cia',
    debug=False,
    strip=False,
    upx=True,
    console=True
)
