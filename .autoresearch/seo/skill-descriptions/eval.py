import sys, re

def score_description(file_path):
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        match = re.search(r'^description:\s*(?:\"|\')?(.*?)(?:\"|\')?$', content, re.MULTILINE)
        if not match: return 0
        desc = match.group(1)
        score = 50
        
        # Length
        if len(desc) > 200: score -= (len(desc) - 200)
        elif len(desc) < 50: score -= 20
            
        # Keywords
        keywords = ["agent", "skill", "plugin", "claude code", "codex", "gemini cli", "cursor", "autonomous", "mcp", "workflow"]
        desc_lower = desc.lower()
        for kw in keywords:
            if kw in desc_lower:
                score += 10
                
        # Anti-spam
        spam = ["comprehensive", "ai-powered", "revolutionary", "ultimate", "synergy"]
        for sp in spam:
            if sp in desc_lower:
                score -= 15
                
        return min(max(int(score), 0), 100)
    except:
        return 0

if len(sys.argv) > 1:
    print(score_description(sys.argv[1]))
else:
    print(0)
