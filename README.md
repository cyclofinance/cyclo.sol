# cyclo.sol

Solidity contracts for Cyclo.

https://cyclo.finance

The bulk of the implementation is dependencies, but this repo implements

- Cyclo receipt contract (shows dynamic pricings in the URI onchain)
- deploy process that uses the Cyclo receipt contract

It is a standalone repo so that it can easily serve as a snapshot for audit and
production deployment of Cyclo that won't get buried in git history.

The relevant dependencies are IN SCOPE of the audit, as at the commits included
as git submodules here.

See the Cyclo website, and rep dependencies for in depth documentation.

## Immutability

Note that Cyclo once deployed has no admin keys and so is immutable onchain.

At that point, this repository is for archival/informational purposes only.

Changes to existing deployments cannot be made, and changes that lead to new,
separate deployments will likely need fresh audits.

## Dev stuff

### Local environment & CI

Uses nixos.

Install `nix develop` - https://nixos.org/download.html.

Run `nix develop` in this repo to drop into the shell. Please ONLY use the nix
version of `foundry` for development, to ensure versions are all compatible.

Read the `flake.nix` file to find some additional commands included for dev and
CI usage.

## Legal stuff

Everything is under DecentraLicense 1.0 (DCL-1.0) which can be found in `LICENSES/`.

This is basically `CAL-1.0` which is an open source license
https://opensource.org/license/cal-1-0

The non-legal summary of DCL-1.0 is that the source is open, as expected, but
also user data in the systems that this code runs on must also be made available
to those users as relevant, and that private keys remain private.

Roughly it's "not your keys, not your coins" aware, as close as we could get in
legalese.

This is the default situation on permissionless blockchains, so shouldn't require
any additional effort by dev-users to adhere to the license terms.

This repo is REUSE 3.2 compliant https://reuse.software/spec-3.2/ and compatible
with `reuse` tooling (also available in the nix shell here).

```
nix develop -c rainix-sol-legal
```

## Contributions

Contributions are welcome **under the same license** as above.

Contributors agree and warrant that their contributions are compliant.