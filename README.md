# Searcheo Server Tuning (Apache / mod-PHP)

This repository contains the **minimal** configuration and cloud‑init script required to
launch a DigitalOcean *WordPress 1‑Click* droplet with Searcheo’s preferred PHP limits,
a 1 GB swapfile, and a basic firewall.

## Files

| Path | Purpose |
|------|---------|
| `cloud-init/apache-oneclick.yaml` | Paste into **User Data** when creating a droplet. |
| `php/8.3-apache/99-searcheo.ini` | Global PHP overrides (memory limit, upload sizes, etc.). |
| `scripts/create_swap.sh` | Adds a 1 GB swapfile and sets `vm.swappiness=10`. |

## Quick Start

1. **Create** a new *WordPress 1‑Click* droplet in DigitalOcean.
2. Under **Advanced Options → User Data**, paste the contents of
   `cloud-init/apache-oneclick.yaml`.
3. Boot the instance — cloud‑init will automatically:
   - Install the PHP overrides,
   - Create and activate the swapfile,
   - Enable UFW for ports 22, 80 and 443,
   - Restart Apache.
4. Verify with:

   ```bash
   php -i | grep memory_limit   # → 256M
   ```

## Updating PHP Version

If DigitalOcean upgrades the marketplace image to a newer PHP branch,
rename the folder (e.g. `8.4-apache`) and adjust the paths in the
cloud‑init file accordingly.

---

MIT License
