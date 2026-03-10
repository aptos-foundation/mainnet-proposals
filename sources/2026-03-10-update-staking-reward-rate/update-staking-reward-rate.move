// Script hash: 9a0555fb
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::staking_config;
    use aptos_framework::block;
    use aptos_framework::fixed_point64;

    fun main(proposal_id: u64) {
        let framework_signer = &aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[],
        );

        let seconds_in_year: u64 = 60 * 60 * 24 * 365;

        // Compute per-epoch reward rate for a 2.6% annual target.
        // StakingRewardsConfig stores a per-epoch rate; the annual rate is
        // per_epoch_rate * num_epochs_per_year. Using 260 bps (2.6%) as the
        // annual numerator over a 10_000 bps denominator scaled by epoch count.
        let epoch_seconds = block::get_epoch_interval_secs();
        let num_epochs_in_a_year = seconds_in_year / epoch_seconds;
        let new_rewards_rate = fixed_point64::create_from_rational(
            260,
            10_000 * (num_epochs_in_a_year as u128),
        );

        // Setting min_rewards_rate equal to new_rewards_rate permanently freezes
        // the rate at 2.6%.
        let min_rewards_rate = new_rewards_rate;

        // rewards_rate_period_in_secs must stay at ONE_YEAR_IN_SECS (31536000);
        // the on-chain validation rejects any other value.
        let rewards_rate_period_sec = seconds_in_year;

        // Preserve the existing 1.5% annual decrease rate (raw FixedPoint64 value
        // for 0.015 = 1.5/100). Effectively a no-op since min_rewards_rate is now
        // equal to new_rewards_rate, but must be kept valid per on-chain constraints.
        // Current on-chain config: https://mainnet.aptoslabs.com/v1/accounts/0x1/resource/0x1::staking_config::StakingRewardsConfig
        let rewards_rate_decrease_rate = fixed_point64::create_from_raw_value(276701161105643274);

        staking_config::update_rewards_config(
            framework_signer,
            new_rewards_rate,
            min_rewards_rate,
            rewards_rate_period_sec,
            rewards_rate_decrease_rate,
        );

        // Trigger an immediate reconfiguration so the new rate takes effect
        aptos_governance::reconfigure(framework_signer);
    }
}
