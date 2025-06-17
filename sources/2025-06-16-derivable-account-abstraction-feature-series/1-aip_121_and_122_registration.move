// Script hash: beab99d6 
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::account_abstraction;
    use std::string::utf8;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[],
        );
        account_abstraction::initialize(
            &framework_signer,
        );
        account_abstraction::register_derivable_authentication_function(
            &framework_signer,
            @0x1,
            utf8(b"solana_derivable_account"),
            utf8(b"authenticate")
        );
        account_abstraction::register_derivable_authentication_function(
            &framework_signer,
            @0x1,
            utf8(b"ethereum_derivable_account"),
            utf8(b"authenticate")
        );
    }
}