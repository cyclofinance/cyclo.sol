# CLAUDE.md

Only what a capable agent would get wrong from this repo alone.

## What this repo is

cyclo.sol is the deploy repo for Cyclo. Today it holds the record of the
production deployments and the rain-deploy machinery the next ones go through;
the contract sources arrive with the rain-vats 0.2.x upgrade (#54).

- `src/legacy/` is the creation bytecode the production contracts were created
  from, as bytes. The sources it was compiled from are not here and are not
  needed: `test/src/legacy/` constructs each one from those bytes and matches it
  to the production code hash, and `test/prod/` matches every live deployment to
  the same hash on a fork.
- `src/lib/LibCycloProd*.sol` are the per-chain addresses, code hashes and
  constructor arguments of those deployments.

## Conventions an agent would get wrong

- Deploys are rain-deploy suites: Zoltu `CREATE2`, one chain-independent
  creation code per suite, declared in `src/abstract/CycloDeploySuites.sol`
  (none yet). A contract whose constructor reads chain state
  (`TwoPriceOracleV2`) cannot be a suite, and a vault clone is an operation, not
  a deployment.
- `src/generated/candidate/` and `src/lib/Lib*Deploy.sol` / `LibReleasedSuites`
  are written by `script/Build.sol`; never hand-edit. `src/generated/<tag>/` is
  frozen by `cutRelease()` and append-only.
- `[external.package].version` is the last released version; only a release
  moves it, in lockstep with a new frozen `<tag>/`.
- Pragma: scripts and tests pin `=0.8.25`; libraries and generated files float
  `^0.8.25`.
- Production code carries the 53-byte ipfs+solc CBOR appendix; the recorded
  creation code carries the 12-byte solc-only one. Comparisons trim either.

## Release / deploy shape

- The on-chain deploy is a human-dispatched `Manual sol artifacts` run, one
  suite per dispatch, before tagging. Nothing automatic broadcasts.
- A manual `sol-v<version>` tag is the sole release trigger.
