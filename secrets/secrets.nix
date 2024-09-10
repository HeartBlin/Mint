let
  heartblin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+IUdSV1gLo5i9RORajWzeTVgI0Rd6LjjR9I3cDh7X+ heartblin@Skadi";
in {
  "GitHubAuth.age".publicKeys = [heartblin];
  "GitHubAuthPub.age".publicKeys = [heartblin];
  "GitHubSign.age".publicKeys = [heartblin];
  "GitHubSignPub.age".publicKeys = [heartblin];
}
