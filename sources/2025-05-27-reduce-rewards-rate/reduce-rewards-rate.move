script {
    use aptos_framework::aptos_governance;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0000000000000000000000000000000000000000000000000000000000000001, vector[]);

        let seconds_in_year: u64 = 60 * 60 * 24 * 365;

        // get the current rewards rate
        let (prev_epoch_rewards_rate_numerator, prev_epoch_rewards_rate_denominator) = staking_config::reward_rate();
        let prev_epoch_rewards_rate = fixed_point64::create_from_rational(prev_epoch_rewards_rate_numerator as u128, prev_epoch_rewards_rate_denominator as u128);

        // get the number of epochs in a year
        let epoch_seconds = block::get_epoch_interval_secs();
        let num_epochs_in_a_year = seconds_in_year / epoch_seconds;
        let aip_reduction = fixed_point64::create_from_rational(25, 10_000 * (num_epochs_in_a_year as u128));
        let new_rewards_rate = prev_epoch_rewards_rate.sub(aip_reduction);

        // remaining values are unchanged
        let min_rewards_rate = fixed_point64::create_from_raw_value(136874841026924);
        let rewards_rate_period_sec = seconds_in_year; // unchanged, 1 year
        let rewards_rate_decrease_rate = fixed_point64::create_from_raw_value(276701161105643274); // unchanged
    
        // Update rewards config to new rewards rate
        staking_config::update_rewards_config(
            framework_signer,
            new_rewards_rate,
            min_rewards_rate,
            rewards_rate_period_sec,
            rewards_rate_decrease_rate,
        );

        // Trigger reconfiguration for changes to take effect immediately
        aptos_governance::reconfigure(&framework_signer);
    }
}
