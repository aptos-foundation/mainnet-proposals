// Script hash: 415960a0 
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::stake;

    fun main(proposal_id: u64) {
        let framework_signer = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[70u8,127u8,54u8,84u8,224u8,128u8,219u8,244u8,223u8,248u8,220u8,188u8,24u8,25u8,100u8,98u8,185u8,65u8,253u8,90u8,138u8,38u8,136u8,131u8,125u8,97u8,245u8,91u8,235u8,197u8,7u8,106u8,],
        );
        stake::initialize_pending_transaction_fee(
            &framework_signer
        );
        stake::set_transaction_fee_limit_per_epoch_per_pool(&framework_signer, 2000000000);  // 20 APT
    }
}
