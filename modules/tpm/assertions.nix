{ config, ... }:

let inherit (config.Ark) secureboot tpm;
in {
  assertions = [{
    assertion = !tpm.enable || secureboot.enable;
    message = ''
      TPM requires that SecureBoot be enabled.
      [config.Ark.secureboot.enable] :: bool
    '';
  }];
}