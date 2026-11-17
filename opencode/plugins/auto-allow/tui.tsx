import { Plugin } from "@opencode/plugin/tui";

export default Plugin.define({
  id: "auto-allow",
  setup(ctx) {
    return ctx.ui.slot({
      append: "prompt.footer.status",
      render: (props) => {
        const session = () =>
          props.sessionID ? ctx.data.session.get(props.sessionID) : undefined;
        const enabled = () => session()?.metadata?.["auto-allow"] === true;

        return (
          <text fg={ctx.theme.text.base}>
            Auto-allow: {props.sessionID && !session() ? "…" : enabled() ? "ON" : "OFF"}
          </text>
        );
      },
    });
  },
});
