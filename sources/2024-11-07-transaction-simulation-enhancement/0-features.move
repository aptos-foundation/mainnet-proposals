// Script hash: 85e0d0d4 
// Modifying on-chain feature flags:
// Enabled Features: [TransactionSimulationEnhancement]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, x"");

        let enabled_blob: vector<u64> = vector[
            78,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
