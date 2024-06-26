// Script hash: 6ee8328a 
// Enable Apple JWK consensus
script {
    use aptos_framework::aptos_governance;
    use aptos_framework::jwks;

    fun main(proposal_id: u64) {
        let framework = aptos_governance::resolve_multi_step_proposal(
            proposal_id,
            @0x1,
            vector[118u8,101u8,99u8,116u8,111u8,114u8,58u8,58u8,101u8,109u8,112u8,116u8,121u8,60u8,117u8,56u8,62u8,40u8,41u8,],
        );

        jwks::upsert_oidc_provider_for_next_epoch(
            &framework,
            b"https://appleid.apple.com",
            b"https://appleid.apple.com/.well-known/openid-configuration"
        );

        aptos_governance::reconfigure(&framework);
    }
}
