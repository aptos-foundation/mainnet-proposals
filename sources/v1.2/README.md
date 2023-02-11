# Overview

There are 4 proposals in this step. Each upgrades a separate package in the Core Aptos Framework (move-stdlib, aptos-stdlib, aptos-framework, aptos-token).
These 4 proposals need to be ordered as some packages such as aptos-framework depend on move-stdlib and aptos-stdlib.
We want to space these proposals out so they're created with an hour in between to allow time for resolution later. 


# Instructions

Run the following steps for each of the 4 upgrade proposals:
1. Verify that the metadata is correct (code location needs to be a raw Github link, discussion points to the correct topic in the forum)
2. To create a proposal on-chain, in the aptos-core repo, run
  ```
  cargo run -p aptos -- governance propose --metadata-url <url-to-metadata-file.json> \
     --pool-address $pool_address --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
     --profile mainnet-voter
  ```
3. Verify that the proposal is created on chain by going to https://governance.aptosfoundation.org/
