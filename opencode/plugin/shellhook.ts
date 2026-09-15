import type { Plugin } from "@opencode-ai/plugin";

export const PodmanConfig: Plugin = async () => ({
  "shell.env": async (_input, output) => {
    output.env.XDG_CONFIG_HOME = `${process.env.HOME}/.config`;
  },
});
