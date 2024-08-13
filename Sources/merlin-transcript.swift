import merlin_transcript

enum InternalError: Error {
    case raiseSign(String)
}

public func internalSignRaiseTranscript<GenericIntoRustString: IntoRustString>(_ public_key: GenericIntoRustString, _ secret: GenericIntoRustString, _ message: GenericIntoRustString) throws -> RustString {
    try { let val = __swift_bridge__$ext_sign_raise_transcript({ let rustString = public_key.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = secret.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = message.intoRustString(); rustString.isOwned = false; return rustString.ptr }()); if val.is_ok { return RustString(ptr: val.ok_or_err!) } else { throw InternalError.raiseSign(RustString(ptr: val.ok_or_err!).toString()) } }()
}


