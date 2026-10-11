-- Anonymous funnel ledger. No IPs or client identifiers, by design.
CREATE TABLE IF NOT EXISTS daily (
  day   TEXT NOT NULL,          -- YYYY-MM-DD (UTC)
  event TEXT NOT NULL,          -- challenge | demo | mcp_demo | mcp_challenge | verify_failed | work_failed | settle_failed | paid
  n     INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (day, event)
);
CREATE TABLE IF NOT EXISTS payments (
  ts      TEXT NOT NULL,
  event   TEXT NOT NULL,
  network TEXT,
  ok      INTEGER NOT NULL,
  reason  TEXT                  -- settlement tx hash on success, failure reason otherwise
);
