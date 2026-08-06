# Hermes GitHub App smoke test

This branch/PR was created automatically by Hermes using the `tophattedagent`
GitHub App installation to verify the end-to-end integration:

1. `git push` over HTTPS authenticated as the app installation (credential
   helper `git-credential-ghapp` mints a short-lived installation token)
2. PR creation via the GitHub REST API, authenticated the same way

Created: 2026-08-06

Safe to close and delete — no functional changes.
