# subdomain.sh —  WIP

>  **Work in progress.** Core functionality works, throttling/optimization still being tuned.

Bash subdomain enumeration script — checks a wordlist of common subdomain prefixes against a target domain, identifies which ones resolve, and checks which of those are running a live web server.

## Current features
- [x] DNS resolution check via `host` (filters out non-existent subdomains)
- [x] Web server detection via `curl` on resolved subdomains
- [x] Results saved to separate files (`live_subdomains.txt`, `web_subdomains.txt`)
- [x] Parallelized execution for speed
- [ ] Concurrency throttling (in progress — prevents system overload on large wordlists)
- [ ] Auto-chaining into recon1 for discovered web subdomains

## Usage
```bash
./subdomain.sh <domain>
```

## Output
- `results/live_subdomains.txt` — all subdomains that resolved via DNS
- `results/web_subdomains.txt` — subdomains that also returned a live HTTP response, with status code

## Notes
Built while learning bash scripting and recon methodology. Uses seclists wordlists (/usr/share/seclists/Discovery/DNS/), needless to say it DOES NOT WORK if you don't have the seclists installed. the wordlist is large so it takes some time to finish.
