import fs from "node:fs";
import * as JSONC from "jsonc-parser";

const GLOB = "*.jsonc";
const OUT_FILE = "opencode.jsonc";

const files = (await Array.fromAsync(new Bun.Glob(GLOB).scan("."))).filter(
  (f) => f !== OUT_FILE,
);

async function build() {
  const merged: Record<string, unknown> = {};
  for (const file of files) {
    const text = await Bun.file(file).text();
    const data = JSONC.parse(text);
    Object.assign(merged, data);
  }
  const lines = [
    "// DO NOT EDIT! Generated via bun merge",
    JSON.stringify(merged, null, 2),
  ];
  await Bun.write(OUT_FILE, lines.join("\n"));
  console.log(`✅ Rebuilt ${OUT_FILE}`);
}

let timer: Timer | undefined;
const DEBOUNCE_MS = 50;
function trigger() {
  if (timer) clearTimeout(timer);
  timer = setTimeout(build, DEBOUNCE_MS);
}

function watch() {
  for (const file of files) {
    fs.watch(file, () => trigger());
  }
  console.log(`Watching: ${files.join(",")}`);
}

// Build once on script run
await build();

if (process.argv.includes("--watch") || process.argv.includes("-w")) watch();
