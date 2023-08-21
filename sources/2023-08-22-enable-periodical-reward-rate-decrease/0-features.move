// Script hash: fd2543be 
// Modifying on-chain feature flags:
// Enabled Features: [PeriodicalRewardRateReduction]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001);

        let enabled_blob: vector<u64> = vector[
            16,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
