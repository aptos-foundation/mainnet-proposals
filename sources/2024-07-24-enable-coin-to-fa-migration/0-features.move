// Script hash: 00b9e9bf 
// Modifying on-chain feature flags:
// Enabled Features: [ConcurrentFungibleAssets, CoinToFungibleAssetMigration]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            x"c6a11ff00d3494f29052baf579e2b38c0eae949fb5da97d0ab68379ef300904e",);
        let enabled_blob: vector<u64> = vector[
            50, 60,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
