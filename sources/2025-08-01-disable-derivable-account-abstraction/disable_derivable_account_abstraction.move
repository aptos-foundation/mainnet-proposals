// Script hash: 81491174
// Modifying on-chain feature flags:
// Enabled Features: []
// Disabled Features: [DerivableAccountAbstraction]
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, x"");

        let enabled_blob: vector<u64> = vector[

        ];

        let disabled_blob: vector<u64> = vector[
            88,
        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}