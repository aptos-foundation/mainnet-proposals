script {
    use aptos_framework::aptos_governance;
    use aptos_framework::staking_config;
    use aptos_std::fixed_point64;
    use std::vector;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001, vector::empty<u8>());
        let (curr_rewards_nominator, curr_rewards_denominator) = staking_config::get_reward_rate(&staking_config::get());
        staking_config::initialize_rewards(
            &framework_signer,
            fixed_point64::create_from_rational((curr_rewards_nominator as u128), (curr_rewards_denominator as u128)), // ~7% APR on mainnet
            fixed_point64::create_from_rational(7420, 1000000000), // ~3.25% APR on mainnet
            365 * 24 * 60 * 60, // 1 year
            1665609760, // 10/12/2022 9:22:40 PM UTC based on transaction #1's timestamp.
            fixed_point64::create_from_rational(15, 1000), // 1.5% every year
        );
        aptos_governance::reconfigure(&framework_signer);
    }
}

