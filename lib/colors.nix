{ lib }:

{
  colors = {
    toHypr = x:
      if (lib.stringLength x) == 6 then
        "rgb(${x})"
      else # Just in case
        throw "Invalid color: ${x}, must be 6 chars long!";
  };
}
