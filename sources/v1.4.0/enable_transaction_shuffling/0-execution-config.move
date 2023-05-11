// Script hash: 6939c5e8 
// Execution config upgrade proposal

// config: V1(
//     ExecutionConfigV1 {
//         transaction_shuffler_type: SenderAwareV1(
//             32,
//         ),
//     },
// )

script {
    use aptos_framework::aptos_governance;
    use aptos_framework::execution_config;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001, vector::empty<u8>());

        let execution_blob: vector<u8> = vector[
            0, 1, 32, 0, 0, 0,
        ];

        execution_config::set(&framework_signer, execution_blob);
    }
}
