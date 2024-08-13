extern crate core;
extern crate merlin;

use merlin::Transcript;
use std::fmt::Write;
use std::num::ParseIntError;
use std::ptr;
use schnorrkel::{
    derive::{CHAIN_CODE_LENGTH, ChainCode, Derivation}, ExpansionMode, Keypair, MiniSecretKey, PublicKey,
    SecretKey, Signature
};
use base64::{engine::general_purpose::STANDARD, Engine};

#[swift_bridge::bridge]
mod ffi {    
    extern "Rust" {
        #[swift_bridge(swift_name = "signRaiseTranscript")]
        fn ext_sign_raise_transcript(
            public_key: String,
            secret: String,
            message: String
        ) -> Result<String, String>;
    }
}

#[no_mangle]
pub fn ext_sign_raise_transcript(
    public_key: String,
    secret: String,
    message: String
) -> Result<String, String> {
    let public_key_vec = decode_slice(&public_key).ok_or("Failed to decoded public key")?;
    let secret_vec = decode_slice(&secret).ok_or("Failed to decoded secret")?;
    let message_vec = decode_slice(&message).ok_or("Failed to decode message")?;

    let secret = create_secret(&secret_vec).ok_or("Failed to create secret")?;
    let public = create_public(&public_key_vec).ok_or("Failed to create public")?;

    let mut transcript = Transcript::new(b"raise-auth");
    transcript.append_message(b"challenge-nonce", &message_vec[..]);

    let signature = secret.sign(transcript, &public);

    let encoded_signature = STANDARD.encode(signature.to_bytes().as_ref());

    Ok(encoded_signature)
}

fn create_public(public: &[u8]) -> Option<PublicKey> {
     match PublicKey::from_bytes(public) {
         Ok(public) => return Some(public),
         Err(_) => return None
     }
 }

fn create_secret(secret: &[u8]) -> Option<SecretKey> {
    match SecretKey::from_bytes(secret) {
        Ok(secret) => return Some(secret),
        Err(_) => return None
    }
 }

fn decode_slice(base64_string: &str) -> Option<Vec<u8>> {
    return STANDARD.decode(base64_string).ok()
}