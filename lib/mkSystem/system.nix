{ hostName, system, stateVersion, timeZone, ... }:

{
  nixpkgs.hostPlatform.system = system;
  system.stateVersion = stateVersion;
  networking.hostName = hostName;
  time.timeZone = timeZone;
  time.hardwareClockInLocalTime = true;
}
