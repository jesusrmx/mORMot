{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit SynopseLCLPkg;

{$warn 5023 off : no warning about unused units}
interface

uses
  SynFPCMetaFile, SynGdiPlus, SynPdf, SynMemoEx, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('SynopseLCLPkg', @Register);
end.
