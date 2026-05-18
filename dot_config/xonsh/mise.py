from pathlib import Path
from xonsh.built_ins import XSH
import subprocess, shlex, shutil, sys, pathlib, os

mise_exe = shutil.which('mise') or str(Path.home() / '.local' / 'bin' / 'mise')

result = subprocess.run(
    [mise_exe, 'activate', '--no-hook-env', 'xonsh'],
    capture_output=True, encoding='UTF-8',
)
XSH.builtins.execx(result.stdout, 'exec', XSH.ctx, filename='mise')

extra_args = shlex.split('')

def mise_hook(**kwargs):
    try:
        script = subprocess.run(
            [mise_exe, 'hook-env', *extra_args, '-s', 'xonsh'],
            env=XSH.env.detype(),
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='UTF-8',
        )
        if script.stderr:
            print(f"mise hook-env stderr: {script.stderr.strip()}", file=sys.stderr)
        if script.stdout:
            XSH.builtins.execx(script.stdout)
            if sys.platform == 'win32':
                XSH.env['PATH'] = XSH.env['Path'].split(os.pathsep)
        has_mise_config = any(
            (pathlib.Path.cwd() / f).exists()
            for f in ('.mise.toml', '.mise.tool-versions', '.tool-versions')
        )
        if not has_mise_config and XSH.env.get('VIRTUAL_ENV'):
            XSH.env.pop('VIRTUAL_ENV')
        if script.stdout:
            XSH.commands_cache._paths_cache.clear()
            XSH.commands_cache.update_cache()
    except Exception as e:
        import traceback
        traceback.print_exc(file=sys.stderr)

XSH.builtins.events.on_pre_prompt(mise_hook)
XSH.builtins.events.on_chdir(mise_hook)
