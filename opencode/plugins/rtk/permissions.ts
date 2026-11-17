import type { Agent } from "@opencode/plugin";

export function addPrefixedShellRules(rules: Agent.Info["permissions"]) {
  const explicit = new Set(
    rules.filter((rule) => rule.action === "shell").map((rule) => rule.resource),
  );
  const result: Agent.Info["permissions"][number][] = [];

  for (const rule of rules) {
    result.push(rule);
    if (rule.action !== "shell" || rule.resource === "*") continue;
    if (/^rtk(?:\s|$)/.test(rule.resource)) continue;

    const resource = `rtk ${rule.resource}`;
    if (!explicit.has(resource)) result.push({ ...rule, resource });
  }

  return result;
}
