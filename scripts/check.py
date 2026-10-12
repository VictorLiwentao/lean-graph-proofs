#!/usr/bin/env python3
"""Direct-compiler fallback after Lake dependencies/cache have been installed."""
from pathlib import Path
import os, re, subprocess
root = Path(__file__).resolve().parents[1]
lean = subprocess.check_output(['elan', 'which', 'lean'], cwd=root, text=True).strip()
out = root / '.lake/build/lib/lean'
out.mkdir(parents=True, exist_ok=True)
deps = sorted((root / '.lake/packages').glob('*/.lake/build/lib/lean'))
if not deps:
    raise SystemExit('Install dependencies first: lake exe cache get')
env = {**os.environ, 'LEAN_PATH': os.pathsep.join(map(str, [out, *deps]))}
seen = set()
def build(name):
    if name in seen:
        return
    source = root / (name.replace('.', '/') + '.lean')
    if not source.is_file():
        return
    seen.add(name)
    for dependency in re.findall(r'^import\s+([A-Za-z0-9_.]+)', source.read_text(), re.M):
        build(dependency)
    target = out / (name.replace('.', '/') + '.olean')
    target.parent.mkdir(parents=True, exist_ok=True)
    print('Checking', name, flush=True)
    subprocess.run([lean, '-DwarningAsError=true', '-DautoImplicit=false',
                    '-DrelaxedAutoImplicit=false', '-DmaxSynthPendingDepth=3',
                    '-o', str(target), str(source.relative_to(root))],
                   cwd=root, env=env, check=True)
build('LeanGraphProofs')
check = root / '.lake/AxiomCheck.lean'
check.write_text('import LeanGraphProofs\n' + ''.join(
    f'#print axioms {name}\n' for name in ['WOWII101.conjecture101', 'WOWII20.conjecture20', 'WOWII7.conjecture7', 'WOWII32.conjecture32', 'WOWII34.conjecture34', 'ResearchWOWII291.conjecture291']))
subprocess.run([lean, str(check)], cwd=root, env=env, check=True)
