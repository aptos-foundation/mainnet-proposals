script {
    use aptos_framework::aptos_governance;
    use aptos_framework::staking_config;
    use std::vector;
    use aptos_std::fixed_point64;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001, vector::empty<u8>());

        let (rewards_rate_numerator, rewards_rate_denominator) = staking_config::reward_rate(); // unchanged
        let prev_rewards_rate = fixed_point64::create_from_rational(rewards_rate_numerator as u128, rewards_rate_denominator as u128);
        let aip_monthly_rewards_rate_reduction = fixed_point64::create_from_rational(25, 10000); // 25 bps
        let new_rewards_rate = prev_rewards_rate.sub(aip_monthly_rewards_rate_reduction); // subtract 25 bps from the current rewards rate
        let min_rewards_rate = fixed_point64::create_from_raw_value(52628560842293);
        let rewards_rate_period_sec = 31536000; // unchanged, 1 year
        let rewards_rate_decrease_rate = fixed_point64::create_from_raw_value(276701161105643274); // unchanged
    
        // Update rewards config to new rewards rate
        staking_config::update_rewards_config(
            &framework_signer,
            new_rewards_rate,
            min_rewards_rate,
            rewards_rate_period_sec,
            rewards_rate_decrease_rate,
        );

        // Trigger reconfiguration for changes to take effect immediately
        aptos_governance::reconfigure(&framework_signer);
    }
}