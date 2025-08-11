The each folder inside `package` should be treated as shared functional or may
even contract only declaration.

Anyway - it should be shared and app-agnostic.

Use `just app_lib_link ...` to add package to app. It will be appeared under the
`lib/[package name]` path.

## Use `just app_lib_unlink ...` to remove lib from app.
