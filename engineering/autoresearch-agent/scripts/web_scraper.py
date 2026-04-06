#!/usr/bin/env python3
"""
Web Scraper / Context Injector (Agent 3 Output)

Fetches external context (like open source repos or docs) to inject into
the autoresearch mutation prompt. Ensures the agent learns from the web
during its autonomous loop.
"""
import argparse
import urllib.request
import re

def scrape_to_markdown(url):
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            html = response.read().decode('utf-8')

            # Extremely basic strip-to-text for token optimization
            # Prioritize Quality and Token Savings
            body = re.sub(r'<style.*?>.*?</style>', '', html, flags=re.DOTALL)
            body = re.sub(r'<script.*?>.*?</script>', '', body, flags=re.DOTALL)
            text = re.sub(r'<[^>]+>', ' ', body)
            clean_text = ' '.join(text.split())

            return clean_text[:5000] # Limit tokens
    except Exception as e:
        return f"Error scraping {url}: {e}"

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", required=True)
    args = parser.parse_args()

    print(scrape_to_markdown(args.url))
