from .aviso import Aviso
from .user import User
from .rotina import Rotina
from .saude import Saude
from .calendario import Calendario



# Create the models directory and write files
models_dir = Path("/mnt/data/models")
models_dir.mkdir(exist_ok=True)

for filename, content in model_files.items():
    (models_dir / filename).write_text(content, encoding="utf-8")

# Return generated filenames for download
[file.name for file in models_dir.glob("*.py")]