// Script hash: c087efb1 
// Modifying on-chain feature flags:
// Enabled Features: [NewAccountsDefaultToFaAptStore, NewAccountsDefaultToFaStore]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            x"22112f3c3f3454984764afc12a0977469f64d94ef38fee7c141ca1204a4cbe08",);
        let enabled_blob: vector<u64> = vector[
            64, 90,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
