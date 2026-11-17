import { homedir } from "node:os";
import { join } from "node:path";
import { Plugin } from "@opencode/plugin";

export default Plugin.define({
  id: "shellhook",
  async setup(ctx) {
    const configHome = join(homedir(), ".config");
    await ctx.shell.hook("create.before", (event) => {
      event.env.XDG_CONFIG_HOME = configHome;
    });
  },
});
