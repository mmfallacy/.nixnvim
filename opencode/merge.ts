import fs from "node:fs";
import * as JSONC from "jsonc-parser";

const GLOB = "*.jsonc";
const OUT_FILE = "opencode.json";

const files = await Array.fromAsync(new Bun.Glob(GLOB).scan("."));

async function build() {
  const merged: Record<string, unknown> = {};
  for (const file of files) {
    const text = await Bun.file(file).text();
    const data = JSONC.parse(text);
    Object.assign(merged, data);
  }
  await Bun.write(OUT_FILE, JSON.stringify(merged, null, 2));
  console.log(`✅ Rebuilt ${OUT_FILE}`);
}

let timer: Timer | undefined;
const DEBOUNCE_MS = 50;
function trigger() {
  if (timer) clearTimeout(timer);
  timer = setTimeout(build, DEBOUNCE_MS);
}

// Build once on script run
await build();

for (const file of files) {
  fs.watch(file, () => trigger());
}

console.log(`Watching: ${files.join(", ")}`);
