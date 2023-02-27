# Overview

There are 2 proposals in this directory. They can be proposed in parallel and executed in any order.

# Instructions

Run the following steps for each of the 2 upgrade proposals:
1. Verify that the metadata is correct (code location needs to be a raw Github link, discussion points to the correct topic in the forum)
2. Download the aptos-core Github repo and make sure you're on the main branch: https://github.com/aptos-labs/aptos-core
3. Make sure you're on Aptos CLI v1.0.6 by running aptos help. If not, follow instructions on aptos.dev to upgrade to v1.0.6
4. To create a proposal on-chain, in the aptos-core repo, run
  ```
  aptos governance propose --metadata-url <url-to-metadata-file.json> \
     --bytecode-version 5 \
     --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
     --pool-address $pool_address \
     --profile mainnet-voter
  ```
3. Verify that the proposal is created on chain by going to https://governance.aptosfoundation.org/
4. Optionally, verify the proposal off chain by running (replace proposal id with the right one from (3))
```
aptos governance verify-proposal --proposal-id [proposal-id] \
     --bytecode-version 5 \
     --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
     --profile mainnet-voter
```
5. When the proposal is ready to execute, run
```
aptos governance execute-proposal --proposal-id <proposal id> \
     --bytecode-version 5 \
     --script-path /path/to/proposal.move \
     --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
     --pool-address $pool_address \
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
