// Script hash: 4d556afb 
// Initialize the nonce table in nonce_validation.moveAdd commentMore actions
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::nonce_validation;
    use std::string::utf8;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[],
        );
        nonce_validation::initialize_nonce_table(
            &framework_signer
        );
    }
}