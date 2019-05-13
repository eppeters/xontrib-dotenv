from itertools import chain
from pathlib import Path

@events.on_chdir
def _dotenv(*args, **kwargs):
    current_path = Path.cwd()
    path_tree = chain([current_path], current_path.parents)
    possible_envs = (p.joinpath('.env') for p in path_tree if p.exists())
    for env in possible_envs:
        if env.exists():
            break
    else:
        env = None

    if (not env or env != ${...}.get('DOTENV')) and ${...}.get('DOTENV_OLD'):
        for k, v in ${...}.get('DOTENV_OLD'):
            if not v:
                del ${...}[k]
            else:
                ${...}[k] = v
        $DOTENV_OLD = []

    if env and env != ${...}.get('DOTENV'):
        $DOTENV_OLD = []
        with env.open('r') as fh:
            for line in fh.readlines():
                line = line.strip().strip('export').strip()
                if line:
                    k, v = line.split('=', 1)
                    $DOTENV_OLD.append((k, ${...}.get(k)))
                    ${...}[k] = v

    $DOTENV = env


_dotenv()
