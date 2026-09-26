import type { Config, Plugin } from "@opencode-ai/plugin"

// RTK OpenCode plugin — rewrites commands to use rtk for token savings.
// Requires: rtk >= 0.23.0 in PATH.
//
// This is a thin delegating plugin: all rewrite logic lives in `rtk rewrite`,
// which is the single source of truth (src/discover/registry.rs).
// To add or change rewrite rules, edit the Rust registry — not this file.

type BashPermission = NonNullable<NonNullable<Config["permission"]>["bash"]>

function mirrorBashRules(bash: BashPermission): BashPermission {
  if (typeof bash === "string") return bash

  const rules: typeof bash = {}
  for (const [pattern, action] of Object.entries(bash)) {
    rules[pattern] = action
    if (pattern === "*" || pattern.startsWith("rtk ")) continue

    const mirrored = `rtk ${pattern}`
    if (!Object.hasOwn(bash, mirrored)) rules[mirrored] = action
  }
  return rules
}

export const RtkOpenCodePlugin: Plugin = async ({ $ }) => {
  try {
    await $`which rtk`.quiet()
  } catch {
    console.warn("[rtk] rtk binary not found in PATH — plugin disabled")
    return {}
  }

  return {
    config: async (config) => {
      if (config.permission?.bash) {
        config.permission.bash = mirrorBashRules(config.permission.bash)
      }
      for (const agent of Object.values(config.agent ?? {})) {
        if (agent.permission?.bash) {
          agent.permission.bash = mirrorBashRules(agent.permission.bash)
        }
      }
    },
    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return
      const args = output?.args
      if (!args || typeof args !== "object") return

      const command = (args as Record<string, unknown>).command
      if (typeof command !== "string" || !command) return

      try {
        const result = await $`rtk rewrite ${command}`.quiet().nothrow()
        const rewritten = String(result.stdout).trim()
        if (rewritten && rewritten !== command) {
          ;(args as Record<string, unknown>).command = rewritten
        }
      } catch {
        // rtk rewrite failed — pass through unchanged
      }
    },
  }
}
