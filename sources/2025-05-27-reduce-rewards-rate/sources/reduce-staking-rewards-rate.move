module AIP119::do_aip {
    use aptos_std::fixed_point64;
    use aptos_framework::block;
    use aptos_framework::staking_config;

    public inline fun do_proposal(framework_signer: &signer) {
        let seconds_in_year: u64 = 60 * 60 * 24 * 365;

        // get the current rewards rate
        let (prev_epoch_rewards_rate_numerator, prev_epoch_rewards_rate_denominator) = staking_config::reward_rate();
        let prev_epoch_rewards_rate = fixed_point64::create_from_rational(prev_epoch_rewards_rate_numerator as u128, prev_epoch_rewards_rate_denominator as u128);

        // get the number of epochs in a year
        let epoch_seconds = block::get_epoch_interval_secs();
        let num_epochs_in_a_year = seconds_in_year / epoch_seconds;
        // AIP reduction is 25 basis points per year, we multiply the denominator by the number of epochs in a year
        // to get the reduction per epoch, that accumulates over the year as a 25bps reduction
        let aip_reduction = fixed_point64::create_from_rational(25, 10_000 * (num_epochs_in_a_year as u128));
        // subtract the AIP reduction from the previous rewards rate
        let new_rewards_rate = prev_epoch_rewards_rate.sub(aip_reduction);

        // remaining values are unchanged
        // "raw" values are stored in 0x1::staking_config::StakingRewardsConfig
        // StakingRewardsConfig can be found here:
        // https://mainnet.aptoslabs.com/v1/accounts/0x1/resource/0x1::staking_config::StakingRewardsConfig
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
    }

    #[test_only]
    use aptos_framework::timestamp;
    #[test_only]
    use aptos_framework::account;

    #[test]
    fun test_reduce_staking_rewards_rate() {
        let framework_signer = account::create_signer_for_test(@0x1);
        // initialize aptos framework
        account::create_account_for_test(@0x1);
        block::initialize_for_test(&framework_signer, 7200 * 1_000_000);
        // constants
        let seconds_in_year = 60 * 60 * 24 * 365;
        assert!(seconds_in_year == 31536000);

        let epoch_seconds = block::get_epoch_interval_secs();
        let num_epochs_in_a_year = seconds_in_year / epoch_seconds;
 
        let start_time_in_secs: u64 = 1728681760; // unchanged
        let min_rewards_rate = fixed_point64::create_from_raw_value(136874841026924);
        let rewards_rate_period_sec = seconds_in_year; // unchanged, 1 year
        let rewards_rate_decrease_rate = fixed_point64::create_from_raw_value(276701161105643274); // unchanged
        let rewards_rate = fixed_point64::create_from_raw_value(286019823949527);

        staking_config::initialize_for_test(&framework_signer, 0, 1, 1, false, 1, 1, 1);
        staking_config::initialize_rewards_for_test(
            &framework_signer,
            rewards_rate,
            min_rewards_rate,
            rewards_rate_period_sec,
            start_time_in_secs,
            rewards_rate_decrease_rate,
        );
        timestamp::update_global_time_for_test(1748898711179663); // 6/2/2025
        staking_config::calculate_and_save_latest_epoch_rewards_rate_for_test();

        let (initial_rewards_rate_numerator, initial_reward_rate_denominator) = staking_config::reward_rate();

        let initial_min_rewards_rate = staking_config::get_min_rewards_rate();
        let initial_rewards_rate_period_sec = staking_config::get_rewards_rate_period_in_secs();
        let initial_rewards_rate_decrease_rate = staking_config::get_rewards_rate_decrease_rate();
        assert!(initial_rewards_rate_numerator ==  999999, initial_rewards_rate_numerator);
        assert!(initial_reward_rate_denominator == 64494634738, initial_reward_rate_denominator);
        assert!(initial_rewards_rate_period_sec == seconds_in_year, initial_rewards_rate_period_sec);
        assert!(initial_rewards_rate_decrease_rate == rewards_rate_decrease_rate);
        assert!(initial_min_rewards_rate == min_rewards_rate);

        do_proposal(&framework_signer);

        timestamp::fast_forward_seconds(1);
        staking_config::calculate_and_save_latest_epoch_rewards_rate_for_test();

        let (final_rewards_rate_numberator, final_reward_rate_denominator) = staking_config::reward_rate();
        let final_min_rewards_rate = staking_config::get_min_rewards_rate();
        let final_rewards_rate_period_sec = staking_config::get_rewards_rate_period_in_secs();
        let final_rewards_rate_decrease_rate = staking_config::get_rewards_rate_decrease_rate();

        let initial_rewards_rate = fixed_point64::create_from_rational(initial_rewards_rate_numerator as u128, initial_reward_rate_denominator as u128);
        let final_rewards_rate = fixed_point64::create_from_rational(final_rewards_rate_numberator as u128, final_reward_rate_denominator as u128);

        let max_rewards_rate: u128 = 1000000;

        let initial_rewards_rate_scaled_per_year = fixed_point64::multiply_u128(
            (num_epochs_in_a_year as u128) * max_rewards_rate,
            initial_rewards_rate,
        );
        let final_rewards_rate_scaled_per_year = fixed_point64::multiply_u128(
            (num_epochs_in_a_year as u128) * max_rewards_rate,
            final_rewards_rate,
        );
        let bps = (25 * max_rewards_rate) / 10_000;
        assert!((initial_rewards_rate_scaled_per_year as u64) == 67912, initial_rewards_rate_scaled_per_year as u64);
        assert!((final_rewards_rate_scaled_per_year as u64) == 65412, final_rewards_rate_scaled_per_year as u64);
        assert!(initial_rewards_rate_scaled_per_year == final_rewards_rate_scaled_per_year + bps);
        std::debug::print(&initial_rewards_rate_scaled_per_year);
        std::debug::print(&final_rewards_rate_scaled_per_year);

        assert!(final_min_rewards_rate == initial_min_rewards_rate);
        assert!(final_rewards_rate_period_sec == initial_rewards_rate_period_sec);
        assert!(final_rewards_rate_decrease_rate == initial_rewards_rate_decrease_rate);
    }
}

script {
    use aptos_framework::aptos_governance;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(proposal_id, @0x1, vector[]);
        AIP119::do_aip::do_proposal(&framework_signer);
        // Trigger reconfiguration for changes to take effect immediately
        aptos_governance::reconfigure(&framework_signer);
    }
}
