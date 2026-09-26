# Code-split defaults

Use only when the user has not supplied explicit code-splitting principles and a source-code boundary in the proposed changes needs judgment:

- Start with the behavior, its consumers, and the narrowest owner of its outcome. Keep private implementation with that owner rather than scattering one capability across technical layers.
- Keep incidental helpers with their consumer; extract meaningful work or a decision when its boundary makes dependencies or direct tests clearer. Neither file length, one caller, nor superficial reuse alone requires extraction.
- Put cross-feature coordination with the caller of the combined outcome. Promote shared code only when distinct owners need a stable contract; investigate sibling imports instead of banning them mechanically.
- Keep direct unit tests with the behavior they protect and cross-feature tests with the composing owner. Do not invent tests for trivial glue.

Assess only changed code. If ownership is unclear, report the evidence and ask rather than inventing a rule; return to the intake feedback gate.
