"""Genera indice y archivos por historia sin modificar la fuente original."""
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
SOURCE = BASE / 'assets/stories/stories.json'

def split():
    stories = json.loads(SOURCE.read_text(encoding='utf-8'))
    folder = SOURCE.parent / 'content'
    folder.mkdir(exist_ok=True)
    index = []
    for story in stories:
        path = folder / (story['id'] + '.json')
        path.write_text(json.dumps(story, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
        summary = {key: value for key, value in story.items() if key != 'nodes'}
        summary['storyAsset'] = path.relative_to(BASE).as_posix()
        summary['nodeIds'] = list(dict.fromkeys(node['id'] for node in story['nodes']))
        index.append(summary)
    output = SOURCE.parent / 'index.json'
    output.write_text(json.dumps(index, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f'Indice: {output.stat().st_size} bytes; {len(index)} historias separadas.')

if __name__ == '__main__':
    split()
