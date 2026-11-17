import { Plugin } from "@opencode/plugin";

export default Plugin.define({
  id: "skill-references",
  async setup(ctx) {
    await ctx.agent.transform((editor) => {
      for (const agent of editor.list()) {
        editor.update(agent.id, (draft) => {
          // Extend the existing ordered rules instead of replacing them.
          draft.permissions.push(
            {
              action: "external_directory",
              resource: "*/skill/*/references/*.md",
              effect: "allow",
            },
            {
              action: "external_directory",
              resource: "*/skills/*/references/*.md",
              effect: "allow",
            },
          );
        });
      }
    });
  },
});
