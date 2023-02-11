# Overview

There are 4 proposals in this step. Each upgrades a separate package in the Core Aptos Framework (move-stdlib, aptos-stdlib, aptos-framework, aptos-token).
These 4 proposals need to be ordered as some packages such as aptos-framework depend on move-stdlib and aptos-stdlib.
We want to space these proposals out so they're created with an hour in between to allow time for resolution later. 


# Instructions

Run the following steps for each of the 4 upgrade proposals:
1. Verify that the metadata is correct (code location needs to be a raw Github link, discussion points to the correct topic in the forum)
2. Download the aptos-core Github repo and make sure you're on the main branch: https://github.com/aptos-labs/aptos-core
3. To create a proposal on-chain, in the aptos-core repo, run
  ```
  cargo run -p aptos -- governance propose --metadata-url <url-to-metadata-file.json> \
     --pool-address $pool_address --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
     --profile mainnet-voter
  ```
3. Verify that the proposal is created on chain by going to https://governance.aptosfoundation.org/
4. Optionally, verify the proposal off chain by running (replace proposal id with the right one from (3))
```
cargo run -p aptos -- governance verify-proposal --proposal-id [proposal-id] \
     --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
     --profile mainnet-voter
```

# Additional verification
If you want to verify that the proposals here are correctly generated, follow these instructions:
1. Download v1.2.0-mainnet.yaml from this directory. You can additionally verify that the content of the yaml makes sense.
2. Generate the proposal scripts: Run `cargo run -p aptos-release-builder -- generate-proposals --release-config <PATH_TO_YAML> --output-dir <PATH_TO_OUTPUT_DIR>`
3. Verify that the contents are the same. You can use checksum hashes to do this quickly by checking that the hashes between what you generated and what's in this directory match. For example:
```
$ shasum -a 256 mainnet/proposals/0/0-move-stdlib.move
5626e9d6b88c8836c15d6a8d2f2197560305ed54c46e2f73de94fb87a1dd4857  mainnet/proposals/0/0-move-stdlib.move
```
