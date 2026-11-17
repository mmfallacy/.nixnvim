import { Plugin } from "@opencode/plugin";

// Enforce the session toggle even when no TUI is connected.
export default Plugin.define({
  id: "yolo",
  async setup(ctx) {
    await ctx.permission.hook("evaluate", async (event) => {
      if (event.effect !== "ask") return;
      const session = await ctx.session.get({ sessionID: event.sessionID });
      if (session.metadata?.["yolo"] === true) event.effect = "allow";
    });
  },
});
