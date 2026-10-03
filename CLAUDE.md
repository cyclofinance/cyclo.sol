# CLAUDE.md

Only what a capable agent would get wrong from this repo alone.

## What this repo is

cyclo.sol is the deploy repo for Cyclo: `CycloVault` and `CycloReceipt`
(thin concretes over the pinned `ethgild` vault), the oracles they price
through, and the deploy pins. The vault logic is not authored here: `lib/` is
the vendored compile closure of the legacy `ethgild` (`rainlanguage/rain.vats`)
submodule tree, kept at the submodule paths so remappings and bytecode are
unchanged; it goes away with the rain-vats 0.2.x upgrade (#54).

## Conventions an agent would get wrong

- Deploys are rain-deploy suites: Zoltu `CREATE2`, one chain-independent
  creation code per suite, declared once in `src/abstract/CycloDeploySuites.sol`.
  A contract whose constructor reads chain state (`TwoPriceOracleV2`) cannot be
  a suite, and a vault clone is an operation, not a deployment; both live in
  `script/CreateVault.sol`.
- `src/generated/candidate/` and `src/lib/Lib*Deploy.sol` / `LibReleasedSuites`
  are written by `script/Build.sol`; never hand-edit. `src/generated/<tag>/`
  is frozen by `cutRelease()` and append-only.
- `[external.package].version` is the last released version; only a release
  moves it, in lockstep with a new frozen `<tag>/`.
- Pragma: concretes, scripts and tests pin `=0.8.25`; libraries and generated
  files float `^0.8.25`.
- `evm_version = "paris"` is kept so the record is the bytes the legacy
  deployments were built from; `bytecode_hash = "none"` leaves the CBOR appendix
  carrying only the solc version, so the record does not move with build config.
- `src/lib/LibCycloProd*.sol` and `test/prod/` are the record of the
  pre-registry per-chain deployments; `test/src/lib/LibCycloProdReproduction.t.sol`
  re-derives every code hash offline.

## Release / deploy shape

- The on-chain deploy is a human-dispatched `Manual sol artifacts` run, one
  suite per dispatch, before tagging. Nothing automatic broadcasts.
- A manual `sol-v<version>` tag is the sole release trigger.
