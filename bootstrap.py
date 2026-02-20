import sys
import os
import tempfile


def get_script_path():
    return os.path.dirname(os.path.realpath(sys.argv[0]))


if sys.platform == 'darwin':
    os.system(f'ln -s {get_script_path()}/.config/yazi ~/.config/yazi')
    os.system('mkdir ~/.config/yazi/flavors')
    with tempfile.TemporaryDirectory() as tmpdir:
        os.system(f'cd {tmpdir} && git clone https://gitlab.com/aimebertrand/timu-macos-yazi.git && cd timu-macos-yazi && cp -r timu-macos-dark.yazi timu-macos-light.yazi ~/.config/yazi/flavors/')
    
