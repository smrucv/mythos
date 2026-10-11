#!/usr/bin/env python3
"""Audita el JSON rescatado; NO lo modifica."""
import collections
import hashlib
import json
import pathlib

BASE = pathlib.Path(__file__).resolve().parent.parent
DATA = BASE / 'assets/stories/stories.json'
OUTPUT = BASE / 'docs/auditoria_historias.json'


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def audit():
    stories = json.loads(DATA.read_text(encoding='utf-8'))
    result = []
    for story in stories:
        nodes = story['nodes']
        counts = collections.Counter(node['id'] for node in nodes)
        duplicated = [node_id for node_id, count in counts.items() if count > 1]
        missing = sorted({
            choice['nextNodeId']
            for node in nodes for choice in node.get('choices', [])
            if choice['nextNodeId'] not in counts
        })
        ambiguity = {}
        for dup in duplicated:
            variants = [node for node in nodes if node['id'] == dup]
            callers = [
                node['id'] for node in nodes
                if any(ch['nextNodeId'] == dup for ch in node.get('choices', []))
            ]
            ambiguity[dup] = {
                'occurrences': len(variants),
                'texts_are_different': len({n['text'] for n in variants}) > 1,
                'incoming_from': callers,
            }
        result.append({
            'id': story['id'],
            'title': story['title'],
            'nodes': len(nodes),
            'unique_node_ids': len(counts),
            'choices': sum(len(n.get('choices', [])) for n in nodes),
            'endings': sum(not n.get('choices') for n in nodes),
            'duplicated_node_ids': duplicated,
            'duplicate_details': ambiguity,
            'missing_targets': missing,
            'cover_exists': (BASE / story['coverImage']).is_file(),
        })
    report = {
        'source': str(DATA.relative_to(BASE)),
        'sha256': sha256(DATA),
        'story_count': len(stories),
        'total_nodes': sum(x['nodes'] for x in result),
        'total_duplicate_ids': sum(len(x['duplicated_node_ids']) for x in result),
        'stories': result,
        'policy': 'Read first occurrence of a duplicated id; never change the original assets.',
    }
    OUTPUT.parent.mkdir(exist_ok=True)
    OUTPUT.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print('Historias:', len(stories))
    for x in result:
        print(f"  {x['title']}: {x['nodes']} nodos, "
              f"{x['choices']} decisiones, {len(x['duplicated_node_ids'])} IDs duplicados, "
              f"{len(x['missing_targets'])} referencias perdidas")
    print('Reporte:', OUTPUT)
    if any(x['missing_targets'] or not x['cover_exists'] for x in result):
        raise SystemExit('Error: falta alguna imagen o destino narrativo.')
    return report


if __name__ == '__main__':
    audit()
