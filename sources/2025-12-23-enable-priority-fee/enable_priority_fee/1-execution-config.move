// Script hash: 467f3654 
// Execution config upgrade proposal

// config: V6(
//     ExecutionConfigV6 {
//         transaction_shuffler_type: UseCaseAware {
//             sender_spread_factor: 32,
//             platform_use_case_spread_factor: 0,
//             user_use_case_spread_factor: 4,
//         },
//         block_gas_limit_type: ComplexLimitV1 {
//             effective_block_gas_limit: 30000,
//             execution_gas_effective_multiplier: 1,
//             io_gas_effective_multiplier: 1,
//             conflict_penalty_window: 9,
//             use_granular_resource_group_conflicts: false,
//             use_module_publishing_block_conflict: true,
//             block_output_limit: Some(
//                 5242880,
//             ),
//             include_user_txn_size_in_block_output: true,
//             add_block_limit_outcome_onchain: true,
//         },
//         enable_per_block_gas_limit: false,
//         transaction_deduper_type: TxnHashAndAuthenticatorV1,
//         gas_price_to_burn: 90,
//     },
// )

script {
    use aptos_framework::aptos_governance;
    use aptos_framework::execution_config;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            x"737b02e2b2ce9ee9a7cdd8b606fc5a108d55bd597181225707ca8bf0b153f338",);
        let execution_blob: vector<u8> = x"060420000000000000000000000000000000040000000000000002307500000000000001000000000000000100000000000000090000000001010000500000000000010100015a00000000000000";

        execution_config::set_for_next_epoch(&framework_signer, execution_blob);
        aptos_governance::reconfigure(&framework_signer);
    }
}
