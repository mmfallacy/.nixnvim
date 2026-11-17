import { expect, test } from "bun:test";
import type { Agent } from "@opencode/plugin";
import { addPrefixedShellRules } from "./permissions";

test("mirrors shell rules in order without changing other permissions", () => {
  const rules = [
    { action: "shell", resource: "*", effect: "ask" },
    { action: "shell", resource: "git *", effect: "allow" },
    { action: "shell", resource: "git push *", effect: "deny" },
    { action: "edit", resource: "*", effect: "deny" },
  ] satisfies Agent.Info["permissions"];
  const original = structuredClone(rules);

  expect(addPrefixedShellRules(rules)).toEqual([
    { action: "shell", resource: "*", effect: "ask" },
    { action: "shell", resource: "git *", effect: "allow" },
    { action: "shell", resource: "rtk git *", effect: "allow" },
    { action: "shell", resource: "git push *", effect: "deny" },
    { action: "shell", resource: "rtk git push *", effect: "deny" },
    { action: "edit", resource: "*", effect: "deny" },
  ]);
  expect(rules).toEqual(original);
});

test("preserves explicit RTK rules instead of generating conflicting copies", () => {
  const rules = [
    { action: "shell", resource: "rtk git *", effect: "deny" },
    { action: "shell", resource: "git *", effect: "allow" },
  ] satisfies Agent.Info["permissions"];

  expect(addPrefixedShellRules(rules)).toEqual(rules);
});

test("only treats an rtk command token as already prefixed", () => {
  expect(
    addPrefixedShellRules([
      { action: "shell", resource: "rtk-helper *", effect: "ask" },
      { action: "shell", resource: "rtk", effect: "allow" },
    ]),
  ).toEqual([
    { action: "shell", resource: "rtk-helper *", effect: "ask" },
    { action: "shell", resource: "rtk rtk-helper *", effect: "ask" },
    { action: "shell", resource: "rtk", effect: "allow" },
  ]);
});

test("does not duplicate generated permissions when replayed", () => {
  const once = addPrefixedShellRules([
    { action: "shell", resource: "git *", effect: "allow" },
  ]);
  expect(addPrefixedShellRules(once)).toEqual(once);
});
