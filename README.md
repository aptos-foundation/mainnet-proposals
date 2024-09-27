# Steps to create a proposal

[![](https://mermaid.ink/img/pako:eNp1kMGKAjEMhl-l5NQF3QeYw4JOZU9e3MXL1kPoZLTSNkNtdUV9dzsjCiLmFP7_S8ifExhuCCpoHR_MBmMSv0oHUWryp6i1gQSKLnLHO3QrMR5_netImHr50_OeRGsdncVUPuQ7_XHbM-2HRC2XXFwOr0A9AEpOumLs6R0wkwvakkmvvhr8bzn7J5OfT4AReIoebVMynnpcQ9qQJw1VaQPlFNFp0OFSUMyJf47BQJViphHkrimRlMV1RA9Vi25XVGps4ji__W143-UKZJlo6w?type=png)](https://mermaid.live/edit#pako:eNp1kMGKAjEMhl-l5NQF3QeYw4JOZU9e3MXL1kPoZLTSNkNtdUV9dzsjCiLmFP7_S8ifExhuCCpoHR_MBmMSv0oHUWryp6i1gQSKLnLHO3QrMR5_netImHr50_OeRGsdncVUPuQ7_XHbM-2HRC2XXFwOr0A9AEpOumLs6R0wkwvakkmvvhr8bzn7J5OfT4AReIoebVMynnpcQ9qQJw1VaQPlFNFp0OFSUMyJf47BQJViphHkrimRlMV1RA9Vi25XVGps4ji__W143-UKZJlo6w)

## Define a proposal:

1. Create a proposal script:
    
    **[Option 1] Use release builder tool**
    - Define the list of change in a YAML file, e.g. [release.yaml](https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/aptos-release-builder/data/release.yaml) in aptos-core
    - After the YAML file is approved, run `cargo run -p aptos-release-builder -- generate-proposals --release-config <PATH_TO_YAML> --output-dir <PATH_TO_OUTPUT_DIR>` to generate upgrade scripts
    
    **[Option 2] Manual process**
    - Use the following template:

    ```
    script {
        use aptos_framework::aptos_governance;

        fun main(proposal_id: u64) {
      	    let framework_signer = aptos_governance::resolve(proposal_id, @1);
      			...
      	}
    }
    ```

2. Upgrade the framework, the account must match where the package is intended to be published. This will create a proposal in `stdlib.move`:
    
    ```
    cargo run -p -- governance generate-upgrade-proposal --account 0x1 --output stdlib.move \
        --package-dir aptos-move/framework/move-stdlib/
    ```

3. Upgrade the gas configuration, this will create a proposal in `gas/sources/update_gas_schedule.move`:

    ```
    cargo run -p aptos-gas -- --output gas
    ```

4. Upload the proposal to this GitHub repository using the proper naming conventions outlined below:
    - Add the metadata to the [metadata folder](https://github.com/aptos-foundation/mainnet-proposals/tree/main/metadata)
      * This includes the `title`, `description` of the proposal, `source_code_url` link to .move file, and `discussion_url` link to GH Issue
    - Create a PR and fill out this [template](https://github.com/aptos-foundation/mainnet-proposals/blob/main/.github/PULL_REQUEST_TEMPLATE.md) in the description
    - Add the move file to the [sources folder](https://github.com/aptos-foundation/mainnet-proposals/tree/main/sources0).

## Create a proposal on-chain
1. To create a proposal on-chain, in the aptos-core repo, run
    ```
    cargo run -p aptos -- governance propose --metadata-url <url-to-metadata-file.json> \
        --pool-address $pool_address --script-path /path/to/proposal.move \
        --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/ \
        --is_multi-step \
        --profile mainnet-voter
    ```
    Note: --is-multi-step is required for proposals that have multiple steps

## Vote on a proposal
To vote on a proposal, use the UI at https://governance.aptosfoundation.org/ or run

    ```
    cargo run -p aptos -- governance vote --proposal-id <proposal-id> --pool-addresses $pool_address_1,$pool_address_2 --yes/no
    ```

## Execute a proposal
To execute a proposal that has passed, in the aptos-core repo, run
    
    ```
    cargo run -p aptos -- governance execute-proposal --proposal-id <proposal-id> \
        --script-path path/to/proposal.move --max-gas 500000 \
        --framework-local-dir /path/to/aptos-core/aptos-move/framework/aptos-framework/
    ```
 If the proposal has multiple steps, run the above command for each of the steps (with --script-path pointing to each specific step)

## Validate proposals
Validate each proposal by checking file naming conventions, checking each link points to it's corresponding file, and descriptions include either the AIP or proposed change. 

## Naming conventions

| Naming Convention | Good Example | Bad Example |
|:--|:--|:--|
| Source Files must start with `step_*` | `step_1_description_of_proposal` | `description_of_proposal`, `step_1`|
| Multistep proposals must use alphabetic characters to maintain a multilevel ordered list | `step_1a`, `step_1b`, `step_1c` | `step_1.1`, `step_1.0`, `step_1_multistep_a`, `step_1_a`|

