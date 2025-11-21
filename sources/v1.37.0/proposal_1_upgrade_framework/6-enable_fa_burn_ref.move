// Script hash: 99412e9f 
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::transaction_fee;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0000000000000000000000000000000000000000000000000000000000000001,
            vector[],
        );
        transaction_fee::convert_to_aptos_fa_burn_ref(&framework_signer);
    }
}
