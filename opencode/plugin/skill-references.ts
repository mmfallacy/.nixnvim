import type { Config, Plugin } from "@opencode-ai/plugin";

function normalize(entry: string | Record<string, string>) {
  if (typeof entry === "string") return { "*": entry };
  return entry ?? {};
}

export const SkillReferences: Plugin = async () => ({
  config: async (config) => {
    let permission = normalize(config.permission);
    let rules = normalize(config.rules);

    rules["*/skill/*/references/*.md"] = "allow";
    rules["*/skills/*/references/*.md"] = "allow";

    permission.external_directory = rules;
    config.permission = permission;
  },
});
