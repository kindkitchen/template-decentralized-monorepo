# 0.4.0

## Differences with prev (v0.3.0)

- No `domain` specific folder, because it is up to user how it will implement
  this (if he even want do this). The last experience show that domain may be
  technically a package (because it is export this members) and be used as lib
  in some app. May be as some specific - it will be good to treat this lib as
  readonly, and all stuff how to use, build it - it should be app scoped stuff.

---

> root => app[], package[]

- The root folder of the project clean from any code specifics
- The each app itself is become dynamic workspace-root
- The package folder contains all libs, that can reuse any app
- The app folder contains these apps

#### What is dynamic workspace root?

Simply speaking, thanks to justfile, the project can be easily reopened one
level deeper with root of some of the apps.

#### How packages will be accessed?

By linking. So any member of package can be linked to any app and become
app/lib/member.

---

- new task - `just format_all_justfiles`
