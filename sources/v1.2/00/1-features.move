// Modifying on-chain feature flags:
// Enabled Features: [CodeDependencyCheck, TreatFriendAsPrivate, VMBinaryFormatV6]
// Disabled Features: []
//
script {
    use aptos_framework::aptos_governance;
    use std::features;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001);

        let enabled_blob: vector<u64> = vector[
            1, 2, 5,
        ];

        let disabled_blob: vector<u64> = vector[

        ];

        features::change_feature_flags(&framework_signer, enabled_blob, disabled_blob);
    }
}
