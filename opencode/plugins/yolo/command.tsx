import { Plugin } from "@opencode/plugin/tui";

export default Plugin.define({
  id: "yolo",
  setup(ctx) {
    ctx.keymap.layer(() => ({
      mode: "global",
      priority: 10,
      commands: [
        {
          id: "yolo.command",
          title: "Toggle automatic permission approval",
          slash: { name: "yolo", arguments: true },
          async run(input) {
            const action = input?.trim().toLowerCase() || "toggle";
            if (!["toggle", "on", "off", "status"].includes(action)) {
              await ctx.ui.dialog.alert({
                title: "YOLO",
                message: "Usage: /yolo [toggle|on|off|status]",
              });
              return;
            }

            const route = ctx.ui.router.current();
            if (route.type !== "session") {
              await ctx.ui.dialog.alert({
                title: "YOLO",
                message: "Open a session before using /yolo.",
              });
              return;
            }

            try {
              const sessionID = route.sessionID;
              const session = await ctx.client.session.get({ sessionID });
              const current = session.metadata?.["yolo"] === true;
              let enabled = current;
              if (action === "toggle") enabled = !current;
              if (action === "on") enabled = true;
              if (action === "off") enabled = false;

              if (action !== "status") {
                await ctx.client.session.update({
                  sessionID,
                  metadata: { ...session.metadata, yolo: enabled },
                });
              }
            } catch (error) {
              await ctx.ui.dialog.alert({
                title: "YOLO",
                message: error instanceof Error ? error.message : String(error),
              });
            }
          },
        },
      ],
    }));
  },
});
