from xonsh.built_ins import XSH
import tempfile, os, pathlib, subprocess

XSH.aliases['ls'] = 'eza'
XSH.aliases['la'] = 'eza -la'
XSH.aliases['ll'] = 'eza -l'

# Yazi cd
def _yazi(args, stdin=None):
    tmp = pathlib.Path(tempfile.mktemp(suffix='.yazi-cwd'))
    try:
        subprocess.run(['yazi', *args, '--cwd-file', str(tmp)])
        if tmp.exists():
            cwd = tmp.read_text(encoding='utf-8').strip()
            if cwd and cwd != os.getcwd():
                XSH.aliases['cd']([cwd])
    finally:
        tmp.unlink(missing_ok=True)

XSH.aliases['y'] = _yazi
