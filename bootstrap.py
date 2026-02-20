import sys
import os
import tempfile
from pathlib import Path


def get_script_path():
    return os.path.dirname(os.path.realpath(sys.argv[0]))


def link(path):
    # print(f'ln -s {get_script_path()}/{path} ~/{path}')
    try:
        (Path.home() / path).symlink_to(Path(get_script_path()) / path)
    except FileExistsError:
        pass
    # os.system(f'ln -s {get_script_path()}/{path} ~/{path}')


if sys.platform == 'darwin':
    link('.vimrc')
    # yazi
    link('.config/yazi')
    os.system('ya pkg add dedukun/bookmarks')
    os.system('mkdir ~/.config/yazi/flavors')
    if not Path('~/.config/yazi/flavors/timu-macos-dark.yazi').expanduser().exists():
        with tempfile.TemporaryDirectory() as tmpdir:
            os.system(f'cd {tmpdir} && git clone https://gitlab.com/aimebertrand/timu-macos-yazi.git && cd timu-macos-yazi && cp -r timu-macos-dark.yazi timu-macos-light.yazi ~/.config/yazi/flavors/')
    # nvim
    link('.config/nvim')
