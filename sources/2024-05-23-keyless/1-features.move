// Script hash: 7ac0fd25 
// Modifying on-chain feature flags:
// Enabled Features: [KeylessAccounts]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[241u8,61u8,115u8,163u8,2u8,181u8,133u8,132u8,27u8,194u8,34u8,236u8,173u8,72u8,116u8,128u8,147u8,81u8,150u8,143u8,200u8,164u8,240u8,195u8,205u8,145u8,103u8,186u8,193u8,44u8,177u8,110u8,],
        );
        let enabled_blob: vector<u64> = vector[
            46,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags_for_next_epoch(&framework_signer, enabled_blob, disabled_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
