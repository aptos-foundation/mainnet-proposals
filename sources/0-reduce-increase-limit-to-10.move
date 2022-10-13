/// This proposal reduces the per-epoch voting power increase limit from 20% to 10%.
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::staking_config;

    fun main(proposal_id: u64) {
        let framework_signer = &aptos_governance::resolve(proposal_id, @aptos_framework);
        // Update the voting power increase limit to 10%.
        staking_config::update_voting_power_increase_limit(framework_signer, 10);

        // End the epoch so the change is synchronized.
        aptos_governance::reconfigure(framework_signer);
    }
}
