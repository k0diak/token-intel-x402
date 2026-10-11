# token-intel-x402 — agent-native Solana token intelligence

One **keyless** call returns a fused safety + market read on any Solana token — mint/freeze
authority, top-holder %, dev holdings, wash-trade (organic) score, liquidity, verification — plus
a **synthesized risk verdict** (`low-risk` / `caution` / `high-risk`) with plain-language flags.

Gated by **x402**: an autonomous agent pays a $0.01 USDC micro-fee per call (Base or Solana) — **no API key, no
account, no signup**. That is the differentiator: every rival (RugCheck, Birdeye, SolSniffer,
GoPlus) needs a key and a signup; this is built for machine-to-machine payment.

Live: **https://token-intel.xrpbreadcrumbs.workers.dev**

```
GET  /api/token-intel?mint=<SPL_MINT>  # PAID (x402) → JSON intelligence
GET  /api/token-intel/demo             # free BONK sample (rate-limited, cached)
POST /mcp                              # MCP server: token_intel (paid) + token_intel_demo (free)
GET  /stats                            # public funnel: challenges, demos, paid calls, revenue
GET  /                                 # free: what it is + how to pay
GET  /healthz                          # free
```

### Deploy (Cloudflare Workers)
Runs on the Workers free plan. v1 lived on Deno Deploy and was suspended when free traffic
exceeded the free tier while paid calls stayed at zero; v2 rate-limits and caches the free demo
so that can't recur, and records every step of the payment funnel in a D1 ledger.

```
npm install
npx wrangler d1 execute token-intel-ledger --remote --file schema.sql   # once
npx wrangler deploy
```
Wallets, price, and facilitator are `[vars]` in `wrangler.toml` (public addresses — no secrets).

### Security by design
- **No private keys, no API keys on the server** — data (Jupiter) and payments (PayAI
  facilitator) are both keyless, so there is nothing here to steal.
- **Read-only toward the outside world; its only writes are an anonymous event ledger (no IPs, no PII)** — near-zero attack surface.
- Pay-to wallet is **receive-only**; its key never touches this host.
- Every paid call requires payment first, so abuse costs the attacker money.
- Input strictly validated (base58 mint) — no SSRF/injection.

_Informational only, not financial advice, no warranty._
