import { Plugin } from "@opencode/plugin/tui";

export default Plugin.define({
  id: "yolo",
  setup(ctx) {
    return ctx.ui.slot({
      append: "prompt.footer.status",
      render: (props) => {
        const session = () =>
          props.sessionID ? ctx.data.session.get(props.sessionID) : undefined;
        const enabled = () => session()?.metadata?.["yolo"] === true;

        return (
          <text fg={ctx.theme.text.base}>
            {session() && enabled() ? "YOLO" : ""}
          </text>
        );
      },
    });
  },
});
