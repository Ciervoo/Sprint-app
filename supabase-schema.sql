-- ============================================================
-- EJECUTAR ESTO en Supabase → SQL Editor → New query
-- ============================================================

CREATE TABLE IF NOT EXISTS clientes (
  id      TEXT PRIMARY KEY,
  nombre  TEXT NOT NULL,
  contacto TEXT DEFAULT '',
  tel     TEXT DEFAULT '',
  zona    TEXT DEFAULT 'Otra',
  dir     TEXT DEFAULT '',
  deuda   NUMERIC DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ventas (
  id        BIGINT PRIMARY KEY,
  cid       TEXT REFERENCES clientes(id) ON DELETE SET NULL,
  pid       TEXT NOT NULL,
  cant      NUMERIC NOT NULL,
  precio    NUMERIC NOT NULL,
  total     NUMERIC NOT NULL,
  costo     NUMERIC DEFAULT 0,
  pago      TEXT DEFAULT 'Transferencia',
  fecha     TEXT NOT NULL,
  notas     TEXT DEFAULT '',
  cobrado   NUMERIC DEFAULT 0,
  entregado BOOLEAN DEFAULT FALSE,
  origen    TEXT DEFAULT 'manual',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS compras (
  id      BIGINT PRIMARY KEY,
  pid     TEXT NOT NULL,
  cant    NUMERIC NOT NULL,
  costo   NUMERIC NOT NULL,
  fecha   TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS stock (
  pid      TEXT PRIMARY KEY,
  cantidad NUMERIC DEFAULT 0
);

CREATE TABLE IF NOT EXISTS pagos (
  id      BIGINT PRIMARY KEY,
  cid     TEXT REFERENCES clientes(id) ON DELETE CASCADE,
  monto   NUMERIC NOT NULL,
  forma   TEXT DEFAULT 'Efectivo',
  fecha   TEXT NOT NULL
);

-- Acceso sin restricciones (uso interno)
ALTER TABLE clientes DISABLE ROW LEVEL SECURITY;
ALTER TABLE ventas   DISABLE ROW LEVEL SECURITY;
ALTER TABLE compras  DISABLE ROW LEVEL SECURITY;
ALTER TABLE stock    DISABLE ROW LEVEL SECURITY;
ALTER TABLE pagos    DISABLE ROW LEVEL SECURITY;
