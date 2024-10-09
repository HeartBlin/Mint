{ lib }:

{
  colors = {
    pallete = {
      bBlue = "089AFF";
      bViolet = "C26EFC";
      bRed = "FA5B59";
      bOrange = "FEA509";
    };

    toHypr = x:
      if (lib.stringLength x) == 6 then
        "rgb(${x})"
      else # Just in case
        throw "Invalid color: ${x}, must be 6 chars long!";
  };
}
