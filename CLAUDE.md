# CLAUDE.md

Only what a capable agent would get wrong from this repo alone.

## What this repo is

cyclo.sol is the deploy repo for Cyclo. Today it holds the record of the
production deployments; the contract sources arrive with the rain-vats 0.2.x
upgrade (#54).

- Each production contract is a rain-deploy candidate whose snapshot,
  `src/generated/candidate/<Contract>.sol`, records the creation code (with the
  constructor arguments that deployment used) and the runtime code. The sources
  are not here and are not needed: `script/Build.sol` regenerates each snapshot
  from the creation code it already records, and
  `test/src/lib/LibCycloProdReproduction.t.sol` matches every recorded runtime
  code to the production code hash. The V2 `CloneFactory` record lives in
  rain.factory.deploy.
- `src/lib/LibCycloProd*.sol` are the per-chain addresses, code hashes and
  constructor arguments of those deployments; `test/prod/` matches every live
  deployment to them on a fork.

## Conventions an agent would get wrong

- Deploys are rain-deploy suites: Zoltu `CREATE2`, one chain-independent
  creation code per suite, declared in `src/abstract/CycloDeploySuites.sol`. The
  production contracts were created with plain `CREATE`; their candidates' Zoltu
  addresses hold nothing until a suite is broadcast. Cutting a release freezes
  them, and chain verification then expects them live at those addresses on
  every supported network.
- `script/Build.sol` reads each snapshot's bytes from its file rather than
  compiling them in: together they exceed the script contract's initcode limit.
- `TwoPriceOracleV2` prices itself in its constructor; Build and the snapshot
  test mock both oracles' `price()` so it constructs offline.
- `src/generated/candidate/` and `src/lib/Lib*Deploy.sol` / `LibReleasedSuites`
  are written by `script/Build.sol`; never hand-edit. `src/generated/<tag>/` is
  frozen by `cutRelease()` and append-only.
- `[external.package].version` is the last released version; only a release
  moves it, in lockstep with a new frozen `<tag>/`.
- Pragma: scripts and tests pin `=0.8.25`; libraries and generated files float
  `^0.8.25`.
- Production code carries the 53-byte ipfs+solc CBOR appendix; the recorded code
  carries the 12-byte solc-only one. Comparisons trim either.

## Release / deploy shape

- The on-chain deploy is a human-dispatched `Manual sol artifacts` run, one
  suite per dispatch, before tagging. Nothing automatic broadcasts.
- A manual `sol-v<version>` tag is the sole release trigger.
