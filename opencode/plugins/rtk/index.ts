import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { Plugin } from "@opencode/plugin";
import { addPrefixedShellRules } from "./permissions";

const exec = promisify(execFile);

// All command rewrite logic belongs to `rtk rewrite` (rtk >= 0.23.0).
export default Plugin.define({
  id: "rtk",
  async setup(ctx) {
    try {
      await exec("rtk", ["--version"], { timeout: 5_000 });
    } catch {
      console.warn("[rtk] rtk unavailable — plugin disabled");
      return;
    }

    await ctx.agent.transform((editor) => {
      for (const agent of editor.list()) {
        editor.update(agent.id, (draft) => {
          draft.permissions = addPrefixedShellRules(draft.permissions);
        });
      }
    });

    await ctx.tool.hook("execute.before", async (event) => {
      if (event.tool !== "shell" && event.tool !== "bash") return;
      const input = event.input;
      if (!input || typeof input !== "object" || !("command" in input)) return;
      const command = input.command;
      if (typeof command !== "string" || !command) return;

      let stdout: string;
      try {
        ({ stdout } = await exec("rtk", ["rewrite", command], {
          encoding: "utf8",
          timeout: 5_000,
        }));
      } catch {
        console.warn("[rtk] rewrite failed — command unchanged");
        return;
      }

      const rewritten = stdout.trim();
      if (rewritten) input.command = rewritten;
    });
  },
});
