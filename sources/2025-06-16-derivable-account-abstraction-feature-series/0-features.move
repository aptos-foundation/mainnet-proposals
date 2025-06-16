// Script hash: 7f74528f 
// Modifying on-chain feature flags:
// Enabled Features: [DerivableAccountAbstraction]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            x"beab99d60b96cc2e846a9683f60899ccea788b6c882382661ed5d5c431247a6a",);
        let enabled_blob: vector<u64> = vector[
            88,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
