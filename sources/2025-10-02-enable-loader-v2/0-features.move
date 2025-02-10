// Script hash: 2300e90b 
// Modifying on-chain feature flags:
// Enabled Features: [EnableLoaderV2]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, x"");

        let enabled_blob: vector<u64> = vector[
            81,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
