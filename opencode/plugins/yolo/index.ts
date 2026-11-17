import { Plugin } from "@opencode/plugin";

export default Plugin.define({
  id: "yolo",
  async setup(ctx) {
    await ctx.command.transform((editor) => {
      editor.add({
        name: "yolo",
        description: "Toggle automatic permission approval (on/off/status)",
        async execute({ sessionID, prompt }) {
          const action = prompt.text.trim().toLowerCase() || "toggle";
          if (!["toggle", "on", "off", "status"].includes(action)) {
            await ctx.session.synthetic({
              sessionID,
              text: "Usage: /yolo [toggle|on|off|status]",
            });
            return;
          }

          const session = await ctx.session.get({ sessionID });
          const current = session.metadata?.["yolo"] === true;
          let enabled = current;
          if (action === "toggle") enabled = !current;
          if (action === "on") enabled = true;
          if (action === "off") enabled = false;

          if (action !== "status") {
            await ctx.session.update({
              sessionID,
              metadata: { ...session.metadata, yolo: enabled },
            });
          }
          await ctx.session.synthetic({
            sessionID,
            text: `YOLO: ${enabled ? "ON" : "OFF"}. Explicit deny rules still apply.`,
          });
        },
      });
    });

    await ctx.permission.hook("evaluate", async (event) => {
      if (event.effect !== "ask") return;
      const session = await ctx.session.get({ sessionID: event.sessionID });
      if (session.metadata?.["yolo"] === true) event.effect = "allow";
    });
  },
});
