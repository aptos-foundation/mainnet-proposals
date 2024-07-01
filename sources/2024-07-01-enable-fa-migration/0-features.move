// Script hash: ae9de990 
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
            x"dd4369fc5fe4674784d0a358d237cc1e20517d6aa0900f0422546be0851bd2d3",);
        let enabled_blob: vector<u64> = vector[
            50, 60,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
