# 0.3.1

## Important!

Utilize folder structure to more flexible way of code organization without
explicit splitting between `app/lib` (app/package).

#### So... remember how it was:

Remember, that previously any folder in `package` one can be imported by any
`app` under the own `lib` folder. So each package is potentially shared codebase
and each app is standalone runnable instance.

#### How it become:

First of all - simply the little convention rules should be used:

1. **Each app should (may) have `core` folder and treat it as library or ready
   to be shared with another app/lib. So it is stuff that can be imported. I
   suppose that as much possible code should be written here. In other words -
   library first style.**
2. The code, that pretty straightforward related to runnable aspect - **should
   not be in this folder**

## So benefits:

Any app can share it's code without worry about cross dependencies. No problem
when some stuff can be almost library except some moments... - write as possible
everything as library - and only runnable logic uniquely, separately,
explicitly.
